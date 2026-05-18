extends Node2D
var Body_Door
@export var door_id = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door_id = get_index()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
