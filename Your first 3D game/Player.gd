extends KinematicBody

export var speed := 15
export var falling_speed := 75

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
		
	direction.y = 0.5 # Makes sure that the pivot don't look up or down. Model looks straight
	$Pivot.look_at(translation + direction, Vector3.UP)
