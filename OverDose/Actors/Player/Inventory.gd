extends Node2D


signal weapon_changed(current_weapon)
signal money_changed(money)


export var money: int = 350 setget set_money


var current_weapon : Node2D
var stored_weapon : Node2D
var weapon_position : Position2D


func initialize(param_weapon_position: Position2D):
	# Player dependency injection
	weapon_position = param_weapon_position


func _instance_weapon(weapon_scene: PackedScene) -> Node2D:
	var weapon_instance = weapon_scene.instance()
	return weapon_instance


func _spawn_weapons():
	# Spawn weapons if there are 0 weapons spawned.
	if weapon_position.get_child_count() == 0 and current_weapon != null:
		weapon_position.add_child(current_weapon)
		if stored_weapon != null and not weapon_position.has_node(stored_weapon.get_path()):
			weapon_position.add_child(stored_weapon)
			stored_weapon.visible = false
	else:
	
	# Spawn Weapons if they are not in the scene
		if current_weapon != null and not weapon_position.has_node(current_weapon.get_path()):
			weapon_position.add_child(current_weapon)
			
		if stored_weapon != null and not weapon_position.has_node(stored_weapon.get_path()):
			weapon_position.add_child(stored_weapon)
			stored_weapon.visible = false


func set_money(new_value) -> void:
	money = new_value
	emit_signal("money_changed", money)
	


func set_weapon(new_weapon: PackedScene) -> void:
	var instanciated_weapon = _instance_weapon(new_weapon)
	var stored_weapon_was_null := false
	
	if current_weapon == null:
		current_weapon = instanciated_weapon
	elif stored_weapon == null:
		stored_weapon = instanciated_weapon
		stored_weapon_was_null = true
	else:
		current_weapon.queue_free()
		current_weapon = instanciated_weapon
	
	_spawn_weapons()
	emit_signal("weapon_changed")
	
	if stored_weapon_was_null:
		swap_weapons()
	
func swap_weapons():
	if stored_weapon == null:
		return
	elif current_weapon.is_reloading:
		return
		
	
	# Switch weapon variables
	var auxiliary = current_weapon
	
	current_weapon = stored_weapon
	stored_weapon = auxiliary
	
	current_weapon.visible = true
	stored_weapon.visible = false
	emit_signal("weapon_changed")
	
	
	
	

