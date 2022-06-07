extends Node2D

onready var bullet_manager = $BulletManager


func _ready() -> void:
	randomize()
	GlobalScripts.connect("bullet_fired", bullet_manager, "handle_bullet_spawn")
