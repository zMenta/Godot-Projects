extends Node2D


var current_weapon : PackedScene
var stored_weapon : PackedScene
var weapon_position : Position2D


func initialize(param_weapon_position: Position2D):
	set_weapon(AllWeapons.weapons["MachinePistol"])
	weapon_position = param_weapon_position
	return _spawn_weapon(current_weapon)


func _spawn_weapon(weapon: PackedScene):
	var weapon_instance = weapon.instance()
	weapon_position.add_child(weapon_instance)
	return weapon_instance


func set_weapon(new_weapon) -> void:
	if current_weapon == null:
		current_weapon = new_weapon
	
	if stored_weapon == null:
		stored_weapon = new_weapon
	else:
		current_weapon = new_weapon


func swap_weapons():
	# Switch weapon variables
	var auxiliary = current_weapon
	
	current_weapon = stored_weapon
	stored_weapon = current_weapon
	
	return _spawn_weapon(current_weapon)
	
	
	

