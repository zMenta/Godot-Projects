extends Control

var is_paused = false setget set_pause

func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("esc"):
		self.is_paused = not is_paused


func set_pause(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_Resume_pressed() -> void:
	self.is_paused = not is_paused


func _on_Quit_Game_pressed() -> void:
	get_tree().quit()


func _on_Restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to(MenuGlobal.level)


func _on_Main_Menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to(MenuGlobal.main_menu)
