extends Node2D

@onready var point_light_2d_2: PointLight2D = $"../PointLight2D2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = point_light_2d_2.global_position
