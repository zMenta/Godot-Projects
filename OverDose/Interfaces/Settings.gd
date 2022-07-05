extends Control


func _on_Back_pressed() -> void:
	if MenuGlobal.main_menu != null:
		get_tree().change_scene_to(MenuGlobal.main_menu)
	
