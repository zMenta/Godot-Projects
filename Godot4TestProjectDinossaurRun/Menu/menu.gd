extends Control

signal game_started


func _unhandled_key_input(event):
	if event.is_action_pressed("jump"):
		game_started.emit()


func _on_start_button_pressed():
	game_started.emit()
