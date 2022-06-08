extends Area2D
class_name Bullet


export var speed := 400

var velocity := Vector2.ZERO
var direction := Vector2.RIGHT setget set_direction


func _physics_process(delta: float) -> void:
	velocity = speed * direction * delta
	position += velocity


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	rotation += direction.angle()


func _on_QueueFreeTimer_timeout() -> void:
	queue_free()
