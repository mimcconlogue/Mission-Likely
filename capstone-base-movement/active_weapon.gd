extends Node2D
var grabbing = false
var current_weapon = 0
var Weapon_animation_set = "animations"
func _input(_event: InputEvent) -> void:
	get_child(current_weapon).check_idle()
	if Input.is_action_just_pressed("attack1"):
		if get_child(current_weapon).current_animation_is_idle == true :
			get_child(current_weapon).current_child.get_child(0).get_child(0).play(Weapon_animation_set + "/" + "attack1")
			get_child(current_weapon).current_animation_is_idle = false
	if Input.is_action_just_pressed("attack2"):
		if get_child(current_weapon).current_animation_is_idle == true :
			get_child(current_weapon).current_child.get_child(0).get_child(0).play(Weapon_animation_set + "/" + "attack2")
			get_child(current_weapon).current_animation_is_idle = false
	if Input.is_action_just_pressed("weapon_up"):
		if get_child(current_weapon).current_animation_is_idle == true :
			get_child(current_weapon).current_child.get_child(0).get_child(0).play(Weapon_animation_set + "/" + "special2")
			get_child(current_weapon).current_animation_is_idle = false
	if Input.is_action_just_pressed("weapon_down"):
		if get_child(current_weapon).current_animation_is_idle == true :
			if get_child(current_weapon).prepared == false :
				get_child(current_weapon).current_child.get_child(0).get_child(0).play(Weapon_animation_set + "/" + "special")
				get_child(current_weapon).current_animation_is_idle = false
				grabbing = true
	if Input.is_action_just_pressed("weapon_1"):
		current_weapon = 1
		get_child(0).hide()
		get_child(2).hide()
		get_child(current_weapon).show()
		get_child(0).process_mode = Node.PROCESS_MODE_DISABLED
		get_child(2).process_mode = Node.PROCESS_MODE_DISABLED
		get_child(current_weapon).process_mode = Node.PROCESS_MODE_INHERIT
	if Input.is_action_just_pressed("weapon_2"):
		current_weapon = 2
		get_child(0).hide()
		get_child(1).hide()
		get_child(current_weapon).show()
		get_child(0).process_mode = Node.PROCESS_MODE_DISABLED
		get_child(1).process_mode = Node.PROCESS_MODE_DISABLED
		get_child(current_weapon).process_mode = Node.PROCESS_MODE_INHERIT
	if Input.is_action_just_pressed("weapon_3"):
		current_weapon = 0
		get_child(2).hide()
		get_child(1).hide()
		get_child(current_weapon).show()
		get_child(1).process_mode = Node.PROCESS_MODE_DISABLED
		get_child(2).process_mode = Node.PROCESS_MODE_DISABLED
		get_child(current_weapon).process_mode = Node.PROCESS_MODE_INHERIT


func _on_weapon_animation_over() -> void:
	if grabbing == true:
		get_child(current_weapon).current_child.get_child(0).get_child(0).play(Weapon_animation_set + "/" + "special_fail")
		grabbing = false
