extends Node2D

onready var bullet_manager := $BulletManager
onready var player := $Player
onready var GUI := $GUI

func _ready() -> void:
	GlobalSignals.connect("bullet_fired", bullet_manager, "on_bullet_fired")
	GUI.initialize(player)

