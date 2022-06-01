extends Node2D


func handle_bullet_spawn(bullet: Bullet, start_position: Vector2, direction: Vector2):
	bullet.position = start_position
	bullet.set_direction(direction)
	add_child(bullet)
