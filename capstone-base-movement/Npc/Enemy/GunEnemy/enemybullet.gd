extends Area2D
@onready var player = get_node("/root/game/player/Legs")
@onready var damage_node = get_node("/root/game/player")
var direction: Vector2 = Vector2.RIGHT
@export var speed = 5000
var blood_damage = 20
var pain_damage = 15

func _physics_process(delta):
	position += transform.x * speed * delta
#if off screen kill bullet
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("collide")
	if body.is_in_group("wall"):
		queue_free()
		print("wall")
	elif body.is_in_group("player"):
		print("hit")
		damage_node.take_damage(blood_damage, pain_damage)
	else:
		pass
