extends Area2D
@onready var player = get_node("/root/game/player/Legs")
@onready var damage_node = get_node("/root/game/player")
var direction: Vector2 = Vector2.RIGHT
@export var speed = 2500
var blood_damage = 20
var pain_damage = 15
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		damage_node.take_damage(blood_damage, pain_damage)
		queue_free()
	elif body.is_in_group("wall"):
		queue_free()

#if off screen kill bullet
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
