extends Node2D

@onready var level := $level01
@onready var player : Player = $Player
@onready var menu : Menu = $Menu
@onready var score_timer := $ScoreTimer

var score := 0

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
	score_timer.stop()
	
	
func _restart_game() -> void:
	get_tree().reload_current_scene()


func _on_score_timer_timeout():
	score += 1
	menu.update_score_label(score)
	
	if score % 50 == 0:
		level.change_obstacle_speed(0.2)
