extends Area2D
class_name Obstacle

const SPEED := 300
var is_moving := true


func _physics_process(delta):
	if is_moving:
		position.x -= SPEED * delta


func _on_obstacle_body_entered(body):
	if body is Player:
		body.death()
