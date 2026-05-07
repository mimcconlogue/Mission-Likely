extends Node2D
@onready var game_display: SubViewport = $"game display"
@onready var sub_viewport: SubViewport = $SubViewport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	game_display.push_input(event)
	sub_viewport.push_input(event)
