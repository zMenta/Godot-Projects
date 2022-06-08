extends Node2D
class_name Weapon


onready var muzzle := $Muzzle
onready var handle := $Handle
onready var cooldown_timer := $FireCooldownTimer
onready var animation_player := $AnimationPlayer


export(PackedScene) var Bullet
export var bullet_damage := 10
export var bullet_direction := Vector2.ZERO
export var max_recoil_angle := 5.0 # Both Axis. 5 + 5 degrees = 10 degress total
export var min_recoil_angle := 2.0
export (float, 1) var recoil_climb_weight := 0.1
export (float, 1) var recoil_recovery_weight := 0.05


var current_recoil := min_recoil_angle


func fire() -> void:
	if cooldown_timer.is_stopped():
		var recoil_radians = deg2rad(rand_range(-current_recoil, current_recoil))
		bullet_direction = handle.global_position.direction_to(muzzle.global_position).rotated(recoil_radians)
		
		# Recoil / spread
		var recoil_increment := max_recoil_angle * recoil_climb_weight
		current_recoil = clamp(current_recoil + recoil_increment, min_recoil_angle, max_recoil_angle)
		
		
		cooldown_timer.start()
		animation_player.play("MuzzleFlash")
		GlobalSignals.emit_signal("bullet_fired", Bullet.instance() ,bullet_direction, muzzle.global_position)

