extends Node2D


signal weapon_changed(weapon)
signal weapon_switched()


var current_weapon : PackedScene
var stored_weapon : PackedScene
var weapon_position : Position2D


func initialize(initialize_weapon_position: Position2D):
	set_weapon(AllWeapons.weapons["Pistol"])
	weapon_position = initialize_weapon_position
	var weapon_instance = current_weapon.instance()
	weapon_position.add_child(weapon_instance)
	return weapon_instance
	

func set_weapon(new_weapon) -> void:
	if current_weapon == null:
		current_weapon = new_weapon
	
	if stored_weapon == null:
		stored_weapon = new_weapon
	else:
		current_weapon = new_weapon


func swap_weapons() -> void:
	var auxiliary = current_weapon
	
	current_weapon = stored_weapon
	stored_weapon = current_weapon

