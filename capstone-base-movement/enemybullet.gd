extends Area2D
var direction: Vector2 = Vector2.RIGHT
@export var speed = 500
func _physics_process(delta):
	position += transform.x * speed * delta
