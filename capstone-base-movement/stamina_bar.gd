
extends ProgressBar
var player 
var stamina
func _ready() -> void:
	player = get_node("/root/game/player")
	update()
func update():
	stamina = player.legs.dodges * 100
	value = stamina/3
