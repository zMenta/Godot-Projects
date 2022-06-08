extends KinematicBody2D


onready var animation_player := $AnimationPlayer


export var speed := 120
export var acceleration := 0.2
export var friction := 0.2

var velocity := Vector2.ZERO



func _physics_process(delta: float) -> void:
	var direction: Vector2 = get_movement_input()	
	
	if direction.length() > 0:
		velocity = lerp(velocity, direction * speed, acceleration)
		$AnimationPlayer.play("Moving")
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		$AnimationPlayer.play("Idle")

	velocity = move_and_slide(velocity)
	

func get_movement_input() -> Vector2:
	var input := Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		input.x += 1
	if Input.is_action_pressed('ui_left'):
		input.x -= 1
	if Input.is_action_pressed('ui_down'):
		input.y += 1
	if Input.is_action_pressed('ui_up'):
		input.y -= 1
	return input.normalized()
	
