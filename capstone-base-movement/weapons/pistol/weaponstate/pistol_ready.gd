extends Node2D
const Bullet = preload("res://weapons/pistol/PistolBullet.tscn")
var idle = true
# Called when the node enters the scene tree for the first time.
@onready var bullet_spawner: Node2D = $"../BulletSpawner"

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	idle=true


func _on_animation_player_animation_started(_anim_name: StringName) -> void:
	idle=false
func shoot():
	var bullet = Bullet.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = bullet_spawner.global_position
	bullet.global_rotation = global_rotation
