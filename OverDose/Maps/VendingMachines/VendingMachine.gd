extends StaticBody2D


export (PackedScene) var weapon = null


var in_range := false
var player : Player = null


func _input(event: InputEvent) -> void:
	if not in_range:
		return
	
	if Input.is_action_just_pressed("interact"):
		if weapon != null:
			player.inventory.set_weapon(weapon)

func _on_BuyRange_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		in_range = true
		player = body


func _on_BuyRange_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		in_range = false
