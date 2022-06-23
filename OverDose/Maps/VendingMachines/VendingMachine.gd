extends StaticBody2D


export (PackedScene) var weapon = null
export var weapon_price : int = 200


var in_range := false
var player : Player = null


func _input(event: InputEvent) -> void:
	if not in_range:
		return
	
	if Input.is_action_just_pressed("interact"):
		if weapon != null and player.inventory.money >= weapon_price:
			player.inventory.set_weapon(weapon)
			player.inventory.money -= weapon_price
			


func _on_BuyRange_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		in_range = true
		player = body


func _on_BuyRange_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		in_range = false