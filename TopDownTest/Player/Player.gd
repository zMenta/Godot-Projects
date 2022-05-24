extends KinematicBody2D

export var speed := 200
export var friction := 0.15
export var acceleration = 0.1
export (int, 0, 100) var push_force = 100

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
	
func _physics_process(delta: float) -> void:
	var direction := get_input()
	look_at(get_global_mouse_position())
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = move_and_slide(velocity, Vector2.ZERO, false, 4, 0.78, false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * push_force)
