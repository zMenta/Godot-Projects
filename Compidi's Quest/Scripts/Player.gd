extends RigidBody2D


var direction : Vector2
var velocity := 0
var speed_y : float
var speed_x : float
onready var ray_cast = $IsOnFloorRay

func _integrate_forces(state):
	# RayCast2D
	if ray_cast.is_colliding():
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
		

