extends KinematicBody

export var speed := 15
export var jump_force := 20
export var falling_acceleration := 75

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
		velocity = move_and_slide(speed * direction, Vector3.UP)
		$Pivot.look_at(global_transform.origin + direction, Vector3.UP)
		
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y += jump_force


	velocity.y -= falling_acceleration * delta
