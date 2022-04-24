extends RigidBody2D


var direction : Vector2
var velocity := 0
var speed_y : float
var speed_x : float

func _integrate_forces(state):
	# Controls
	if Input.is_action_pressed("m1_click"):
		direction = get_local_mouse_position().normalized()
		velocity += 10
		$ProgressBar.value = velocity
	if Input.is_action_just_released("m1_click"):
		state.apply_central_impulse(direction * $ProgressBar.value)
		
		velocity = 0	
		$ProgressBar.value = 0

func _process(delta: float) -> void:
	# Animation
	if linear_velocity.length() > 70:
		$AnimatedSprite.set_animation("jump")
	else:
		$AnimatedSprite.set_animation("rest")
		

