extends Control


func _ready() -> void:
	if OS.window_fullscreen:
		$VBoxContainer/FullScreenCheckBox.pressed = true


func _on_Back_pressed() -> void:
	if MenuGlobal.main_menu != null:
		get_tree().change_scene_to(MenuGlobal.main_menu)
	

func _on_FullScreenCheckBox_pressed() -> void:
	OS.window_fullscreen = not OS.window_fullscreen
