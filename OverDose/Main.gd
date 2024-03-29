extends Node2D


onready var bullet_manager := $BulletManager
onready var player := $Player
onready var GUI := $GUI
onready var zombie_manager := $ZombieManager
onready var map := $Map1
onready var camera := $Camera2D


func _ready() -> void:
	randomize()
	GlobalSignals.connect("bullet_fired", bullet_manager, "on_bullet_fired")
	GUI.initialize(player, zombie_manager)
	zombie_manager.set_tilemap(map.get_tilemap())
	GlobalSignals.connect("gun_fired", self, "weapon_fired")
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("f11"):
		OS.window_fullscreen = not OS.window_fullscreen
		
		
func weapon_fired(trauma_amount):
	camera.add_trauma(trauma_amount)
