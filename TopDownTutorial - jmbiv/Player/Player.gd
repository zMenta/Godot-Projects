extends KinematicBody2D
class_name Player

signal player_fired_gun(bullet, position, direction)

export (PackedScene) var Bullet
export var speed := 150


onready var gun = $Gun
onready var gun_muzzle = $GunMuzzle
onready var attack_cooldown = $AttackCooldown
onready var muzzle_flash = $MuzzleFlash
onready var animation_player = $AnimationPlayer


func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	if 	Input.is_action_pressed("ui_left"): direction.x = -1
	if 	Input.is_action_pressed("ui_right"): direction.x = 1
	if 	Input.is_action_pressed("ui_up"): direction.y = -1
	if 	Input.is_action_pressed("ui_down"): direction.y = 1
	
	direction = direction.normalized()
	move_and_slide(direction * speed)
	look_at(get_global_mouse_position())
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"): shoot()
	

func shoot() -> void:
	if attack_cooldown.is_stopped():
		var bullet_instance = Bullet.instance()
		var direction = gun.global_position.direction_to(gun_muzzle.global_position).normalized()
		emit_signal("player_fired_gun", bullet_instance, to_global(gun_muzzle.position), direction)
		attack_cooldown.start()
		animation_player.play("muzzle_flash")
		
func handle_hit() -> void:
	pass
	
