extends KinematicBody2D

export var speed := 80
export var friction := 0.2
export var acceleration := 0.1
export (int, 0, 100) var push_force := 100
export (float, 0, 1) var turning_weight := 0.1
export (float, 0, 1)onready var camera_weigth := 1


var reload_time := 1.2
var velocity := Vector2.ZERO
onready var animations: Array = $AnimatedSprite.frames.get_animation_names()
onready var particles := $Muzzle/FiringParticles
onready var arm := $Arm
onready var weapon := $Arms

enum anim_state {
	aiming,
	idle,
	reloading
}


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("reload") and $AnimatedSprite.animation != animations[anim_state.reloading]:
		$AnimatedSprite.animation = animations[anim_state.reloading]
		speed = 30
		yield(get_tree().create_timer(reload_time), "timeout")
		$AnimatedSprite.animation = animations[anim_state.idle]
		speed = 100
	
	if Input.is_action_pressed("aim") and $AnimatedSprite.animation != animations[anim_state.reloading]:
		speed = 30
		$AnimatedSprite.animation = animations[anim_state.aiming]
	elif $AnimatedSprite.animation == animations[anim_state.aiming]:
		$AnimatedSprite.animation = animations[anim_state.idle]
		speed = 100
		
#	if Input.is_action_pressed("attack"):
#		weapon.play_shovel()
		
			
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
	
	
func move_camera(target: Vector2, interpolation_weight := camera_weigth) -> void:
	var mid_x = (self.global_position.x + target.x) / 2
	var mid_y = (self.global_position.y + target.y) / 2
	
	$Camera2D.global_position = $Camera2D.global_position.linear_interpolate(Vector2(mid_x, mid_y), interpolation_weight)
	
	
func _physics_process(delta: float) -> void:
	var direction := get_movement_input()


	# Camera
	move_camera(get_global_mouse_position())
	
	# Player Rotation to mouse position
	rotation = lerp_angle(rotation,
	 (get_global_mouse_position() - global_position).normalized().angle(),
	 turning_weight)

	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
		$Drawing.play_animation()	
		$DrawingArms.play_animation()	
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		$Drawing.stop_animation()
		$DrawingArms.stop_animation()
	
	velocity = move_and_slide(velocity, Vector2.ZERO, false, 4, 0.78, false)
	# Collision with RigidBodies2D
	for index in get_slide_count():
		var collision := get_slide_collision(index)
		if collision.collider is RigidBody2D:
			var local_collision_position: Vector2 = collision.position.direction_to(collision.collider.position) * -1
			collision.collider.apply_impulse( local_collision_position * (push_force/12) , -collision.normal * push_force)
