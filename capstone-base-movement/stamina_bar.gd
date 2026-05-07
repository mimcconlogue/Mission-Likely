
extends ProgressBar
var player
var stamina
func _ready() -> void:
	player = get_parent().get_parent().get_parent().get_node("LitViewport").get_child(2)
	update()
func update():
	stamina = player.get_child(1).dodges
	value = stamina/3
