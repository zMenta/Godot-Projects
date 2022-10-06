extends Control

signal game_started
signal game_restarted

@onready var label : Label = $Label
@onready var button : Button = $StartButton


func _unhandled_key_input(event):
	if event.is_action_pressed("jump"):
		emit_start_game()

func _on_start_button_pressed():
	emit_start_game()

#	if button.text == 

func emit_start_game() -> void:
	visible = false
	game_started.emit()
	
	if button.text == "Restart":
		game_restarted.emit()

func change_to_restart_layout() -> void:
	visible = true
	label.text = 'Press "SpaceBar" to restart'
	button.text = "Restart"
