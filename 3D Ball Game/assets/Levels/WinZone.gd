extends Area


func _on_WinZone_body_entered(body: Node) -> void:
	if body.name == "Ball":
		print("you won")
