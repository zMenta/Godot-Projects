extends Node2D

@onready var level := $level01
@onready var player : Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	player.died.connect(level._on_Player_death)

