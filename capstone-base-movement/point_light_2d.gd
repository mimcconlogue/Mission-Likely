extends PointLight2D
@onready var camera_2d: Camera2D = $"../Camera2D"

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_parent().get_child(0).get_child(1).get_child(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position=player.global_position
	look_at(camera_2d.position)
