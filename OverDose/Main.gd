extends Node2D

onready var bullet_manager := $BulletManager
onready var player := $Player
onready var GUI := $GUI
onready var zombie_manager := $ZombieManager
onready var tilemap := $MapNavigation/TileMap

func _ready() -> void:
	randomize()
	GlobalSignals.connect("bullet_fired", bullet_manager, "on_bullet_fired")
	GUI.initialize(player, zombie_manager)
	zombie_manager.set_tilemap(tilemap)

