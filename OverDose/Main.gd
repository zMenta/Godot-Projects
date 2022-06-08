extends Node2D

onready var bullet_manager := $BulletManager

func _ready() -> void:
	GlobalSignals.connect("bullet_fired", bullet_manager, "on_bullet_fired")

