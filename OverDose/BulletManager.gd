extends Node2D


func on_bullet_fired(bullet_instance, bullet_direction: Vector2, bullet_position: Vector2) -> void:
	bullet_instance.position = bullet_position
	bullet_instance.set_direction(bullet_direction)
	bullet_instance.add_child()
