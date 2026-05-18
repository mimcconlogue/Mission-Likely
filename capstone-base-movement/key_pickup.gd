extends Area2D





func _on_area_entered(area: Area2D) -> void:
	has_key.has_key = true
	queue_free()
