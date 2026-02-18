extends CharacterBody2D
@onready var player = get_node("/root/game/player/Legs")
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var timer = %Timer
@export var speed = 15000
var tween = null
var health = 100
var in_detect_range = false
var detecting = false
var detected = false
var attack_distance = 200.0
var recently_attacked = false
var rotation_speed = PI

#start chase if u stay spotted too long lil bro
func _on_timer_timeout() -> void:
	detected = true
	detecting = false
	print("give chase")
#first check if player entered fov
#if they do then check if enemy has los w player
#look at player if in detection radius with a tween
func _on_detection_area_body_entered(_body: Node2D) -> void:
	in_detect_range = true
	var direction = (player.global_position - global_position).normalized()
	var target_angle = direction.angle()
	detecting = true
	timer.start()
	print("timer started, player detected")
	if tween: 
		tween.kill()
	tween = create_tween()
	tween.set_loops()
	tween.tween_property(self,"rotation",target_angle, 0.75).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

#if player leaves dont do the stuff up there^
func _on_detection_area_body_exited(_body: Node2D) -> void:
	if tween:
			tween.kill()
	detected = false
	detecting = false
	in_detect_range = false
	timer.stop()
	print("player got away :(")

func _physics_process(delta: float):
	#look at player while
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
