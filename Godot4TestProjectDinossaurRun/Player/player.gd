extends CharacterBody2D

const JUMP_VELOCITY := -175
const MAX_JUMP_VELOCITY := -1100

var _gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var _can_jump := false

# Movement
func _physics_process(delta):
	# Jumping code, the jump will be higher if the jump key be held for longer.
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		_can_jump = true
	
	if Input.is_action_pressed("jump") and _can_jump:
		velocity.y += JUMP_VELOCITY
		if velocity.y < MAX_JUMP_VELOCITY:
			_can_jump = false
			
	if Input.is_action_just_released("jump"):
		_can_jump = false

	move_and_slide()

