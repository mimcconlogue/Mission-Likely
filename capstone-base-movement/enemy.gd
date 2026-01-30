extends CharacterBody2D
@onready var player = get_node("/root/game/player/Legs")
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var timer = %Timer
@export var speed = 20000
var health = 100
var detected = false
var detection_distance = 250.0
var recently_attacked = false
#start chase if u stay spotted too long lil bro
func _on_timer_timeout() -> void:
	detected = true
	print("give chase")

#look at player if in detection radius with a tween
func _on_detection_area_body_entered(body: Node2D) -> void:
	var direction = (player.global_position - global_position).normalized()
	var target_angle = direction.angle()
	var tween = create_tween()
	tween.tween_property(self,"rotation",target_angle, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	timer.start()
	print("timer started, player detected")

#if player leaves dont do the stuff up there^
func _on_detection_area_body_exited(body: Node2D) -> void:
	detected = false
	timer.stop()
	print("left detection")

func _physics_process(delta):
	#detect distance from player for attack
	var distance_to_player: float = global_position.distance_to(player.global_position)
	#if u get spotted
	if detected: 
		#move to player and look at them
		var direction = position.direction_to(player.position)
		velocity = speed * direction * delta
		look_at(player.position)
		#if u close enough attack & stop move...
		if distance_to_player < detection_distance:
			animation_player.play("swing")
			recently_attacked = true
			print("THROWIN HANDS")
		#...else play idle anim (stop swing) and keep moving
		elif recently_attacked:
			await animation_player.animation_finished
			animation_player.play("idle")
			recently_attacked = false
		else: 
			animation_player.play("idle")
			move_and_slide()
	
	
