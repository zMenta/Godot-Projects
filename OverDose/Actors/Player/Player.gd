extends KinematicBody2D
class_name Player

onready var movement := $Movement
onready var player_center := $PlayerCenter
onready var weapon_position := $PlayerCenter/WeaponPosition
onready var animation_player := $AnimationPlayer
onready var inventory := $Inventory


export var hit_points : int = 3

var player_current_weapon : Node2D = null
var alive := true


func _ready() -> void:
	player_current_weapon = inventory.initialize(weapon_position)
#	inventory.set_weapon(AllWeapons.weapons["Pistol"])
#	pass


func _unhandled_key_input(event: InputEventKey) -> void:
	if Input.is_action_just_pressed("swap_weapons"):
		inventory.delete_secondary()
#		player_current_weapon.queue_free()
#		player_current_weapon = inventory.swap_weapons()


func _physics_process(delta: float) -> void:
	if alive == false or inventory == null:
		return
	
	move_weapon_to_mouse()
	movement.direction = get_movement_input()
	movement.move(delta)

	if inventory.current_weapon is Weapon:
		if Input.is_action_pressed("shoot"):
			inventory.current_weapon.fire()
		
		elif Input.is_action_just_pressed("reload"):
			inventory.current_weapon.reload()


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

