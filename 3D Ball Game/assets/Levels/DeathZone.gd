extends Area


func _on_DeathZone_body_entered(body: Node) -> void:
	if body.name == "Ball":
		get_tree().reload_current_scene()
