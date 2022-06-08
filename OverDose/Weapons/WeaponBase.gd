extends Node2D
class_name Weapon


onready var muzzle := $Muzzle
onready var handle := $Handle
onready var cooldown_timer := $FireCooldownTimer
onready var animation_player := $AnimationPlayer
onready var tween := $Tween
onready var weapon_sprite := $WeaponSprite


export(PackedScene) var Bullet
export var max_recoil_angle := 5.0 # Both Axis. 5 + 5 degrees = 10 degress total
export var min_recoil_angle := 2.0
export (float, 1) var recoil_climb_weight := 0.1
export (float, 1) var recoil_recovery_weight := 0.05


var current_recoil := min_recoil_angle
var bullet_direction := Vector2.ZERO


func _physics_process(delta: float) -> void:
	if not Input.is_action_pressed("shoot"):
		var recoil_decrement := max_recoil_angle * recoil_recovery_weight
		current_recoil = clamp(current_recoil - recoil_decrement, min_recoil_angle, max_recoil_angle)


func fire() -> void:
	if cooldown_timer.is_stopped():
		var recoil_radians = deg2rad(rand_range(-current_recoil, current_recoil))
		bullet_direction = handle.global_position.direction_to(muzzle.global_position).rotated(recoil_radians)
		
		# Recoil / spread
		var recoil_increment := max_recoil_angle * recoil_climb_weight
		current_recoil = clamp(current_recoil + recoil_increment, min_recoil_angle, max_recoil_angle)
		
		
		# Tween
		var tween_up_time := 0.1
		var tween_down_time := 0.15
		var random_recoil_rotation = -rand_range(deg2rad(5), deg2rad(30))
		tween.interpolate_property(weapon_sprite, "rotation", weapon_sprite.rotation, random_recoil_rotation, tween_up_time)
		tween.interpolate_property(weapon_sprite, "rotation", weapon_sprite.rotation, 0, tween_down_time, tween.TRANS_CUBIC, tween.EASE_IN, tween_up_time)
		
		tween.start()
		
		cooldown_timer.start()
		animation_player.play("MuzzleFlash")
		GlobalSignals.emit_signal("bullet_fired", Bullet.instance() ,bullet_direction, muzzle.global_position)

