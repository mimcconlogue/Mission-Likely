extends CharacterBody2D
@onready var player = get_node("/root/game/player/Legs")
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var timer = %Timer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var weapon_shape = get_node("EnemyWeapon/WeaponHurtbox/CollisionPolygon2D")
@export var speed = 15000
var tween = null
var health = 100
var timer_not_active = true
var detectable = false
var detected = false
var attack_distance = 200.0
var recently_attacked = false
var rotation_speed = PI
var player_visible = false
var blood: int = 100
var max_blood: int = 100
var pain: int = 100
var max_pain: int = 100
var morale = 5

func _ready() -> void:
	weapon_activate()
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
		detected = true
		timer_not_active = false
		detectable = false
		print("give chase")

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

func _physics_process(delta: float):
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
				timer.stop()
	#detect distance from player for attack
	var distance_to_player: float = global_position.distance_to(player.global_position)
	#if u get spotted
	if detected: 
		if tween:
			tween.kill()
		#move to player and look at them
		var direction = (player.global_position - global_position).normalized()
		velocity = speed * direction * delta
		#all of this for rotation
		var target_angle = direction.angle()
		rotation = lerp_angle(rotation, target_angle, delta * rotation_speed)
		#if u close enough attack & stop move...
		if distance_to_player < attack_distance:
			print("THROWIN HANDS")
			animation_player.play("swing")
			recently_attacked = true
			await animation_player.animation_finished
			print("attack finished!")
		#...else play idle anim (stop swing) and keep moving
		elif recently_attacked:
			await animation_player.animation_finished
			animation_player.play("idle")
			recently_attacked = false
		else: 
			animation_player.play("idle")
			move_and_slide()
func weapon_disable():
	weapon_shape.set_disabled(true)
func weapon_activate():
	weapon_shape.set_disabled(false)

func die():
	queue_free()
func _on_area_2d_area_entered(_area: Area2D) -> void:
	print("Take That!")
	take_damage(5,15)
