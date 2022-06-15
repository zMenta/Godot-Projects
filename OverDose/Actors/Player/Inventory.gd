extends Node2D

export (PackedScene) var default_weapon 


enum {
	SLOT1,
	SLOT2
}


var weapon_slots := {
	SLOT1: null,
	SLOT2: null
}


func _ready() -> void:
	set_weapon(default_weapon, SLOT1)


func set_weapon(weapon: Weapon, slot: int) -> void:
	weapon_slots[slot] = weapon
	


