extends Control
@onready var level_complete_menu: Control = $CanvasLayer/LevelCompleteMenu
func _ready() -> void:
	level_complete_menu.visible = false
func end_screen():
	level_complete_menu.show()
