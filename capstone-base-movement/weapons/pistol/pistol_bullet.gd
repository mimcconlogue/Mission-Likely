extends Area2D
@onready var player = get_node("/root/game/player/Legs")
@onready var damage_node = get_node("/root/game/player")
var direction: Vector2 = Vector2.RIGHT
@export var speed = 5000
var blood_damage = 20
var pain_damage = 15
var found_target = false
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("wall"):
		queue_free()
		
	else:
		var target = body.name
		var index = 0
		while found_target == false :
			print (get_node("/root/game/enemies/"+target).name)
			if get_node("/root/game/enemies/"+target).name == target:
				found_target = true
				get_node("/root/game/enemies/"+target).take_damage(25,35)
