extends Node2D


signal weapon_changed(weapon)
signal weapon_switched()


enum {
	SLOT1,
	SLOT2
}


onready var weapon_slots := {
	SLOT1: null,
	SLOT2: null
}


var current_weapon: Weapon = null


func initialize(weapon: Weapon, slot := 1) -> void:
	set_weapon(weapon, slot)
	current_weapon = weapon


func set_weapon(weapon: Weapon, slot: int) -> void:
	weapon_slots[slot] = weapon
	emit_signal("weapon_changed", weapon_slots[slot])
	

func swap_weapons() -> void:
	pass

