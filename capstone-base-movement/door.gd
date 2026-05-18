extends Node2D
@export var door : Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var key = 0
@export var door_id = 0
var in_range = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("use"):
		interact()
func interact():
	if in_range == true:
		if has_key.has_key == true:
			animation_player.play("open")
func _on_area_2d_area_entered(area: Area2D) -> void:
	in_range = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	in_range = false
