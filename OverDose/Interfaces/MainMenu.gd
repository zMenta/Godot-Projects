extends Control


onready var play_button := $VBoxContainer/Play


func _on_Play_pressed() -> void:
	if MenuGlobal.level != null:
		get_tree().change_scene_to(MenuGlobal.level)


func _on_Quit_pressed() -> void:
	get_tree().quit()


func _on_Settings_pressed() -> void:
	if MenuGlobal.settings_menu != null:
		get_tree().change_scene_to(MenuGlobal.settings_menu)
