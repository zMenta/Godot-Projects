extends Area2D
class_name Bullet


signal bullet_hit(bullet_damage)

export var speed := 400
export var damage := 10.0

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


func _on_Bullet_body_entered(body: Node) -> void:
	if body.has_method("on_bullet_hit"):
		emit_signal("bullet_hit", damage)
	queue_free()
