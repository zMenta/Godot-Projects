extends Node2D
class_name Weapon

signal weapon_fired(bullet, position, direction)

export (PackedScene) var Bullet

onready var gun = $Gun
onready var gun_muzzle = $GunMuzzle
onready var attack_cooldown = $AttackCooldown
onready var muzzle_flash = $MuzzleFlash
onready var animation_player = $AnimationPlayer

	
func fire() -> void:
	if attack_cooldown.is_stopped():
		var bullet_instance = Bullet.instance()
		var direction = gun.global_position.direction_to(gun_muzzle.global_position).normalized()
		emit_signal("weapon_fired", bullet_instance, to_global(gun_muzzle.position), direction)
		attack_cooldown.start()
		animation_player.play("muzzle_flash")
