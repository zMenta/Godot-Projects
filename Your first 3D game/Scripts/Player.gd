extends KinematicBody

# Player speed in meters/seconds
export var speed := 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration := 75

var velocity := Vector3.ZERO


func _physics_process(delta: float) -> void:
	
	var direction := Vector3.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_down"):
		direction.z = 1
	if Input.is_action_pressed("ui_up"):
		direction.z = -1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
		
	
	# Ground
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# Air
	velocity.y -= fall_acceleration * delta
	# Character movement
	velocity = move_and_slide(velocity, Vector3.UP)
	
