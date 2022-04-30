extends KinematicBody2D

export var SPEED := 350
export var WHEEL_ROTATION_SPEED := 6

var screen = OS.get_window_safe_area().size

func _physics_process(delta: float) -> void:
	position.x = clamp(position.x, 0+60, screen.x-60)
	var direction := Vector2.ZERO
	var mouse_position = get_global_mouse_position()
	$CannonPivot.look_at(mouse_position)

	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		$WheelRight.rotation_degrees -= WHEEL_ROTATION_SPEED
		$WheelLeft.rotation_degrees -= WHEEL_ROTATION_SPEED
	if Input.is_action_pressed("ui_right"):
		$WheelRight.rotation_degrees += WHEEL_ROTATION_SPEED
		$WheelLeft.rotation_degrees += WHEEL_ROTATION_SPEED
		direction.x = 1

	move_and_slide(SPEED*direction, Vector2.UP)
