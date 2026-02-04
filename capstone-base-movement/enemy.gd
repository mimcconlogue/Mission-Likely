extends CharacterBody2D
@onready var player = get_node("/root/game/player/Legs")
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var timer = %Timer
@export var speed = 20000
@onready var ray_cast_2d = $Raycasts/RayCast2D
var tween = null
var health = 100
var detected = false
var detection_distance = 250.0
var recently_attacked = false
var rotation_speed = PI
var cone_angle = 80.0
var raycast_speed = 300.0
var raycast_angle = 0.0
var raycast_direction = 1

#start chase if u stay spotted too long lil bro
func _on_timer_timeout() -> void:
	pass
func _physics_process(delta: float):
	raycast_angle += raycast_speed * raycast_direction * delta
	#reverse direction at end of cone
	if abs(raycast_angle) > cone_angle / 2.0:
		raycast_direction *= -1
		
	ray_cast_2d.rotation_degrees = raycast_angle
	#scan for player 
	ray_cast_2d.force_raycast_update()
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider == player:
			print("detecterd")
			detected = true
	
	
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
		if distance_to_player < detection_distance:
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
