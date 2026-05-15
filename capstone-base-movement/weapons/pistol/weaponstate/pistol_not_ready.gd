extends Node2D
signal animation_over
var idle = true
# Called when the node enters the scene tree for the first time.



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	idle = true
	animation_over.emit()

func _on_animation_player_animation_started(_anim_name: StringName) -> void:
	idle = false
	
