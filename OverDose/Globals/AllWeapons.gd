extends Node

var weapons: Dictionary = {}

func _ready() -> void:
	weapons["MachinePistol"] = preload("res://Weapons/MachinePistol_w/MachinePistol.tscn")
	weapons["Pistol"] = preload("res://Weapons/Pistol_w/Pistol.tscn")
	weapons["Shotgun"] = preload("res://Weapons/PumpShotgun_w/PumpShotgun.tscn")
	
