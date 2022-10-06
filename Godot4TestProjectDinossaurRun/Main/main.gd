extends Node2D

@onready var level := $level01
@onready var player : Player = $Player
@onready var menu := $Menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	player.died.connect(_player_died)
	menu.game_started.connect(_start_game)
	menu.game_restarted.connect(_restart_game)
	get_tree().paused = true


func _start_game() -> void:
	get_tree().paused = false


func _player_died() -> void:
	level.stop_world()
	menu.change_to_restart_layout()

	
func _restart_game() -> void:
	print("reloaded")
	get_tree().reload_current_scene()
