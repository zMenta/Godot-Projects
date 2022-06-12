extends KinematicBody2D
class_name Player

onready var movement := $Movement
onready var player_center := $PlayerCenter
onready var weapon_position := $PlayerCenter/WeaponPosition
onready var weapon := $PlayerCenter/WeaponPosition/MachinePistol
onready var animation_player := $AnimationPlayer


export var hit_points : int = 3


var alive := true


func _ready() -> void:
	rotation_degrees = 0

func _physics_process(delta: float) -> void:
	if alive == true:
		move_weapon_to_mouse()
		movement.direction = get_movement_input()
		
		if Input.is_action_pressed("shoot"):
			weapon.fire()
		
		if Input.is_action_just_pressed("reload"):
			weapon.reload()


func move_weapon_to_mouse():
	player_center.look_at(get_global_mouse_position())
	var direction_to_mouse: Vector2 = player_center.global_position.direction_to(get_global_mouse_position())
	
	if direction_to_mouse.x > 0:
		weapon_position.scale = Vector2(1,1)
	if direction_to_mouse.x < 0:
		weapon_position.scale = Vector2(1,-1)
	
	
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


func death():
	alive = false
	movement.direction = Vector2.ZERO
	animation_player.play("death")
	

func on_zombie_hit():
	if alive:
		animation_player.play("take_damage")
		hit_points -= 1
		if hit_points <= 0:
			death()
