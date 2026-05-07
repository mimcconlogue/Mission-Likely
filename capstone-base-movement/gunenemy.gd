extends CharacterBody2D
@onready var player = get_node("/root/game/game display/player/Legs")
@onready var timer = %Timer
@onready var shoot_timer: Timer = %ShootTimer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var gun: Marker2D = $Marker2D
@onready var idle_timer: Timer = %IdleTimer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var gun_enemy: CharacterBody2D = $"."

const Bullet = preload("res://enemybullet.tscn")
var move_speed = 175
var can_walk = true
var tween = null
var health = 100
var can_shoot = true
var timer_not_active = true
var detectable = false
var detected = false
var attack_distance = 1000.0
var rotation_speed = PI
var player_visible = false
var blood: int = 100
var max_blood: int = 100
var pain: int = 100
var max_pain: int = 100
var morale = 5


func take_damage(blood_damage, pain_damage):
	blood = blood - blood_damage
	pain = pain - pain_damage
	detect_death()
func detect_death():
	if blood <= 0:
		die()
	if pain <= 0:
		die()
#start chase if u stay spotted too long lil bro
func _on_timer_timeout() -> void:
	if player_visible:
		can_walk = true
		detected = true
		timer_not_active = false
		detectable = false
		print("give chase")
	else:
		print("I see noone")

func _on_detection_area_body_entered(_body: Node2D) -> void:
	detectable = true
	timer_not_active = true

#if player leaves dont do the stuff up there^
func _on_detection_area_body_exited(_body: Node2D) -> void:
	if tween:
			tween.kill()
	detected = false
	detectable = false
	timer_not_active = true
	timer.stop()
	print("player got away :(")

func _physics_process(_delta: float):
	#first check if player entered fov
	#if they do then check if enemy has los w player
	#look at player if in detection radius with a tween
	if player_visible and detectable:
		var direction = (player.global_position - global_position).normalized()
		var target_angle = direction.angle()
		if timer_not_active:
			timer.start()
			timer_not_active = false
		if tween: 
			tween.kill()
		tween = create_tween()
		tween.set_loops()
		tween.tween_property(self,"rotation",target_angle, 0.75).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	#check line o sight
	var player_local_position = ray_cast_2d.to_local(player.global_position)
	ray_cast_2d.target_position = player_local_position
	ray_cast_2d.force_raycast_update()
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider == player:
			player_visible = true
		else:
			player_visible = false
			timer_not_active = true
			timer.stop()

	#detect distance from player for attack
	var distance_to_player: float = global_position.distance_to(player.global_position)
	#if u get spotted
	if detected: 
		#still need to not lock rotation
		if tween: 
			tween.kill()
		#if u close enough attack & stop move...
		if distance_to_player < attack_distance and player_visible:
			if can_shoot:
				velocity = Vector2.ZERO
				can_walk = false
				shoot()
		elif not can_walk:
			velocity = Vector2.ZERO
			if idle_timer.is_stopped():
				idle_timer.start()
				print("timerstart")
		elif can_walk: 
			#print("move that gear up!")
			var current_position: Vector2 = self.global_transform.origin
			var next_path_position: Vector2 = nav_agent.get_next_path_position()
			var new_velocity: Vector2 = current_position.direction_to(next_path_position)
			nav_agent.velocity = new_velocity
			update_target_position(player.global_transform.origin)
		else:
			print("uh oh")
		#all of this for rotation
		var direction = global_position.direction_to(player.global_position)
		gun_enemy.rotation = direction.angle()
		
func update_target_position(target_pos: Vector2):
	nav_agent.target_position = target_pos



func die():
	queue_free()
func _on_area_2d_area_entered(_area: Area2D) -> void:
	print("Take That!")
	take_damage(5,15)

func shoot():
	velocity = Vector2.ZERO
	can_shoot = false
	var bullet = Bullet.instantiate()
	get_tree().root.get_child(0).get_child(0).add_child(bullet)
	bullet.global_position = gun.global_position
	bullet.global_rotation = gun.global_rotation
	shoot_timer.start()
	idle_timer.stop()

func _on_shoot_timer_timeout() -> void:
	can_shoot = true
func _on_idle_timer_timeout() -> void:
	can_shoot = true
	can_walk = true
	print("idle done")


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = velocity.move_toward(safe_velocity * move_speed, 12.0)
	move_and_slide()
