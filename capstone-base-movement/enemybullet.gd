extends Area2D
var direction: Vector2 = Vector2.RIGHT
@export var speed = 500
signal bullet_hit(damage)
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_entered(_area: Area2D) -> void:
	emit_signal("bullet_hit", 20)
	queue_free()
