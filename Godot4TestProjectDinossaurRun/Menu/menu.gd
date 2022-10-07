extends Control
class_name Menu

signal game_started
signal game_restarted

@onready var label : Label = $MainMenu/Label
@onready var score_label : Label = $ScoreLabel
@onready var button : Button = $MainMenu/StartButton
@onready var main_menu := $MainMenu


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
		

func change_to_restart_layout() -> void:
	main_menu.visible = true
	label.text = 'Press "SpaceBar" to restart'
	button.text = "Restart"


func update_score_label(new_value: int) -> void:
	score_label.text = str(new_value)

