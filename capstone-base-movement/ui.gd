extends Control
@onready var level_complete_menu: Control = $CanvasLayer/LevelCompleteMenu
func end_screen():
	level_complete_menu.show()
