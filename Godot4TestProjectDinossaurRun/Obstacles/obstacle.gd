extends Area2D
class_name Obstacle

var speed := 300
var is_moving := true


func _physics_process(delta):
	if is_moving:
		position.x -= speed * delta


func _on_obstacle_body_entered(body):
	if body is Player:
		body.death()

func stop() -> void:
	is_moving = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
