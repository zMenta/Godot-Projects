extends Area2D
class_name Bullet

export var speed := 800
var direction := Vector2.ZERO


func _physics_process(delta: float) -> void:
	position += speed * delta * direction


func _on_DespawnTimer_timeout() -> void:
	queue_free()


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	rotation += direction.angle()
