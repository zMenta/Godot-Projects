extends Area2D


func _on_Paddle_area_entered(area: Area2D) -> void:
	if area.is_in_group("ball"):
		area.direction.x *= -1
