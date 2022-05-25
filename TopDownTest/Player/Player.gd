extends KinematicBody2D

export var speed := 100
export var friction := 0.2
export var acceleration := 0.1
export (int, 0, 100) var push_force := 100
export (float, 0, 1) var turning_weight := 0.1
export (float, 0, 1)onready var camera_weigth := 1

var velocity := Vector2.ZERO

func get_input() -> Vector2:
	var input := Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		input.x += 1
	if Input.is_action_pressed('ui_left'):
		input.x -= 1
	if Input.is_action_pressed('ui_down'):
		input.y += 1
	if Input.is_action_pressed('ui_up'):
		input.y -= 1
	return input
	
func move_camera(target: Vector2, interpolation_weight := camera_weigth) -> void:
	var mid_x = (self.global_position.x + target.x) / 2
	var mid_y = (self.global_position.y + target.y) / 2
	
	$Camera2D.global_position = $Camera2D.global_position.linear_interpolate(Vector2(mid_x, mid_y), interpolation_weight)
	
	
func _physics_process(delta: float) -> void:
	var direction := get_input()

	# Camera
	move_camera(get_global_mouse_position())
	
	# Player Rotation to mouse position
	rotation = lerp_angle(rotation,
	 (get_global_mouse_position() - global_position).normalized().angle(),
	 turning_weight)

	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	
	velocity = move_and_slide(velocity, Vector2.ZERO, false, 4, 0.78, false)
	# Collision with RigidBodies2D
	for index in get_slide_count():
		var collision := get_slide_collision(index)
		if collision.collider is RigidBody2D:
			var local_collision_position: Vector2 = collision.position.direction_to(collision.collider.position) * -1
			collision.collider.apply_impulse( local_collision_position * (push_force/12) , -collision.normal * push_force)
