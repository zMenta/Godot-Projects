extends Control

signal game_started


func _unhandled_key_input(event):
	if event.is_action_pressed("jump"):
		emit_start_game()

func _on_start_button_pressed():
	emit_start_game()

func emit_start_game() -> void:
	visible = false
	game_started.emit()
