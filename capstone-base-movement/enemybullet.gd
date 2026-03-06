extends Area2D
@onready var player = get_node("/root/game/player/Legs")
var direction: Vector2 = Vector2.RIGHT
@export var speed = 500
var blood_damage = 20
var pain_damage = 15
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(blood_damage, pain_damage)
		queue_free()
