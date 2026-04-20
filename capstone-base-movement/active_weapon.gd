extends Node2D
var grabbing = false
func _input(event: InputEvent) -> void:
	get_child(0).check_idle()
	if Input.is_action_just_pressed("attack1"):
		if get_child(0).current_animation_is_idle == true :
			get_child(0).current_child.get_child(0).get_child(0).play("attack1")
			get_child(0).current_animation_is_idle = false
	if Input.is_action_just_pressed("attack2"):
		if get_child(0).current_animation_is_idle == true :
			get_child(0).current_child.get_child(0).get_child(0).play("attack2")
			get_child(0).current_animation_is_idle = false
	if Input.is_action_just_pressed("weapon_up"):
		if get_child(0).current_animation_is_idle == true :
			get_child(0).current_child.get_child(0).get_child(0).play("special2")
			get_child(0).current_animation_is_idle = false
	if Input.is_action_just_pressed("weapon_down"):
		if get_child(0).current_animation_is_idle == true :
			if get_child(0).prepared == false :
				get_child(0).current_child.get_child(0).get_child(0).play("special")
				get_child(0).current_animation_is_idle = false
				grabbing = true


func _on_weapon_animation_over() -> void:
	if grabbing == true:
		get_child(0).current_child.get_child(0).get_child(0).play("special_fail")
		grabbing = false
