extends Control

func _on_reset_pressed() -> void:
	get_tree().reload_current_scene()
