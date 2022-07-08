extends KinematicBody

signal died

export var speed := 15.0
export var jump_force := 20.0
export var falling_acceleration := 75.0
export var bounce_force := 16

var velocity := Vector3.ZERO


func _physics_process(delta: float) -> void:
	var direction := Vector3.ZERO
	
	if Input.is_action_pressed("foward"):
		direction.z -= 1
	if Input.is_action_pressed("backwards"):
		direction.z += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
		
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(global_transform.origin + direction, Vector3.UP)
		
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y += jump_force

	velocity.y -= falling_acceleration * delta

	velocity = move_and_slide(velocity, Vector3.UP)
	
	
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("mob"):
			var mob = collision.collider
			if Vector3.UP.dot(collision.normal) > 0.1:
				mob.squash()
				velocity.y = bounce_force

func die():
	queue_free()
		
		
func _on_HurtBox_body_entered(body: Node) -> void:
	emit_signal("died")
	die()
