extends Control
@onready var fader: ColorRect = $Fader
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("RESET")
	fader.visible = true
	animation_player.play("fade_to_clear")
func _on_start_button_pressed() -> void:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://game.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
