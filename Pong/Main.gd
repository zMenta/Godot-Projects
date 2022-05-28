extends Node


func _on_ScreenArea_area_exited(area: Area2D) -> void:
	if area.is_in_group("ball"):
		area.direction.y *= -1
		area.increase_speed(20)
		print(area.speed)
