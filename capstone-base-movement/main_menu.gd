extends Control
@onready var fader: ColorRect = $CanvasLayer/Fader


func _ready() -> void:
	fader.modulate.a = 1.0
	fade_to_clear(.25)


func _on_start_button_pressed() -> void:
	await fade_to_black(1.0)
	get_tree().change_scene_to_file("res://game.tscn")

func _on_exit_button_pressed() -> void:
	await fade_to_black(.5)
	get_tree().quit()

func fade_to_black(duration: float = 1.0):
	var tween = create_tween()
	tween.tween_property(fader, "modulate:a", 1.0, duration).from_current()
	await tween.finished
func fade_to_clear(duration: float = 1.0):
	var tween = create_tween()
	tween.tween_property(fader, "modulate:a", 0.0, duration).from_current()
	await tween.finished
