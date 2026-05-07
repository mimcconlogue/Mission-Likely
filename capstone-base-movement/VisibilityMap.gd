extends TileMapLayer

@onready var map: Node2D = $"../../game display/map"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = map.scale
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
