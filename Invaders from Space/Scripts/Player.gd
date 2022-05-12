extends KinematicBody2D

export (PackedScene) var Bullet 
export var SPEED := 350
export var WHEEL_ROTATION_SPEED := 6
export (Vector2) var recoil 
export (float) var recoil_recovery_time

var can_shoot := true

var screen = OS.get_window_safe_area().size
onready var wheels := $Wheels.get_children()

func _physics_process(delta: float) -> void:
	position.x = clamp(position.x, 0+60, screen.x-60)
	var direction := Vector2.ZERO
	var mouse_position = get_global_mouse_position()
	$CannonPivot.look_at(mouse_position)
	
	if Input.is_action_pressed("shoot"):
		if can_shoot == true:
			shoot()
			can_shoot = false
			$ShootCooldown.start()
			
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		for wheel in wheels:
			wheel.rotation_degrees -= WHEEL_ROTATION_SPEED
	if Input.is_action_pressed("ui_right"):
		for wheel in wheels:
			wheel.rotation_degrees += WHEEL_ROTATION_SPEED
		direction.x = 1

	move_and_slide(SPEED*direction, Vector2.UP)
	

func shoot() -> void:
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.transform = $CannonPivot/Cannon/MuzzlePosition.global_transform
	recoil()
	
func recoil() -> void:
	"""
	Cannon and Hull recoil on shoot()
	"""
	$CannonPivot/Cannon.position -= recoil
	$Hull.position += Vector2(0,recoil.x/6)
	yield(get_tree().create_timer(recoil_recovery_time), "timeout")
	$Hull.position -= Vector2(0,recoil.x/6)
	$CannonPivot/Cannon.position += recoil
	
	
func _on_ShootCooldown_timeout() -> void:
	can_shoot = true
