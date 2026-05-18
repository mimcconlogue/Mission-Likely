extends Area2D

func _on_area_entered(_area: Area2D) -> void:
	has_key.has_gun = true
	queue_free()
	
