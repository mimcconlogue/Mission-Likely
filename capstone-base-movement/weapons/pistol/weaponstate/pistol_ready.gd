extends Node2D
const Bullet = preload("res://playerbullet.tscn")
@onready var animation_player: AnimationPlayer = $Ready/AnimationPlayer
@onready var barrel: Node2D = $barrel
@onready var game_display = get_node("/root/game/game_display")
var idle = true
var gun_ready = true
var bullets = 6
var cocked = true
# Called when the node enters the scene tree for the first time.
@onready var animated_sprite_2d_idle: AnimatedSprite2D = $Idle/AnimatedSprite2DIdle

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	idle=true


func _on_animation_player_animation_started(_anim_name: StringName) -> void:
	idle=false
func shoot():
	if bullets > 0:
		if cocked == true:
			if get_parent().open == false:
				var bullet = Bullet.instantiate()
				game_display.add_child(bullet)
				bullet.global_position = barrel.global_position
				bullet.global_rotation = barrel.global_rotation
				bullets = bullets - 1
				cocked = false
				animation_player.play("animations 2/attack1_2")
				animated_sprite_2d_idle.animation = "uncocked"
	else:
		pass
func cock():
	if get_parent().open == true:
		pass
	else:
		if cocked == false:
			animation_player.play("animations 2/special_1")
			cocked = true
			animated_sprite_2d_idle.animation = "cocked"
		else:
			animated_sprite_2d_idle.animation = "cocked"
			pass
