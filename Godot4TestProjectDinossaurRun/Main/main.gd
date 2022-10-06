extends Node2D

@onready var level := $level01
@onready var player : Player = $Player
@onready var menu := $Menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	player.died.connect(level._on_Player_death)
	menu.game_started.connect(_start_game)
	get_tree().paused = true

func _start_game() -> void:
	get_tree().paused = false
