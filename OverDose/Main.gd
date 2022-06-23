extends Node2D


onready var bullet_manager := $BulletManager
onready var player := $Player
onready var GUI := $GUI
onready var zombie_manager := $ZombieManager
onready var map := $Map1


func _ready() -> void:
	randomize()
	GlobalSignals.connect("bullet_fired", bullet_manager, "on_bullet_fired")
	GUI.initialize(player, zombie_manager)
	zombie_manager.set_tilemap(map.get_tilemap())


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("f11"):
		OS.window_fullscreen = not OS.window_fullscreen
