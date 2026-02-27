
extends ProgressBar
var player 
func _ready() -> void:
	player = get_node("/root/game/player")
	update()
func update():
	value = player.blood
