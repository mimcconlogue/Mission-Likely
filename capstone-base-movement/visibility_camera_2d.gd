extends Camera2D

var master_camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_camera = get_parent().get_parent().get_child(0).get_child(1).get_child(0).get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position= master_camera.global_position 
