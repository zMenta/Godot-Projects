extends Node

var weapons: Dictionary = {}

func _ready() -> void:
	print("Autoloaded weapons :000")
	weapons["MachinePistol"] = preload("res://Weapons/MachinePistol_w/MachinePistol.tscn")
	weapons["Pistol"] = preload("res://Weapons/Pistol_w/Pistol.tscn")
	
