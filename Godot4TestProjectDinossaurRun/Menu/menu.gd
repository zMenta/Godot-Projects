extends Control

signal game_started
signal game_restarted

@onready var label : Label = $MainMenu/Label
@onready var score_label : Label = $ScoreLabel
@onready var score_timer : Timer = $ScoreTimer
@onready var button : Button = $MainMenu/StartButton
@onready var main_menu := $MainMenu

var _game_started := false
var score := 0


func _unhandled_key_input(event):
	if event.is_action_pressed("jump"):
		emit_start_game()


func _on_start_button_pressed():
	emit_start_game()


func emit_start_game() -> void:
	main_menu.visible = false
	game_started.emit()
	
	if button.text == "Restart":
		game_restarted.emit()

	if not _game_started:
		score = 0
		score_timer.start()
		_game_started = true	
		

func change_to_restart_layout() -> void:
	main_menu.visible = true
	label.text = 'Press "SpaceBar" to restart'
	button.text = "Restart"


func _on_score_timer_timeout() -> void:
	score += 1
	score_label.text = str(score)


func stop_score_timer() -> void:
	score_timer.stop()
