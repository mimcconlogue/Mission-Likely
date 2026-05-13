extends Control


func _ready() -> void:
	visible = true

func _on_reset_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
