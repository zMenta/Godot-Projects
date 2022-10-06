extends Area2D

const SPEED := 300

func _physics_process(delta):
	position.x -= SPEED * delta



func _on_obstacle_body_entered(body):
	print(body)
