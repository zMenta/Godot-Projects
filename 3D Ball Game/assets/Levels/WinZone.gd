extends Area

export(String, FILE, "*.tscn") var NEXT_LEVEL = ""

func _on_WinZone_body_entered(body: Node) -> void:
	if body.name == "Ball" and NEXT_LEVEL != "":
		get_tree().change_scene(NEXT_LEVEL)
