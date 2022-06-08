extends Node2D
class_name Weapon


onready var muzzle := $Muzzle
onready var handle := $Handle
onready var cooldown_timer := $FireCooldownTimer
onready var animation_player := $AnimationPlayer


export(PackedScene) var Bullet
export var bullet_damage := 10
export var bullet_direction := Vector2.ZERO


func fire() -> void:
	if cooldown_timer.is_stopped():
		bullet_direction = handle.global_position.direction_to(muzzle.global_position)
		cooldown_timer.start()
		animation_player.play("MuzzleFlash")
		GlobalSignals.emit_signal("bullet_fired", Bullet.instance() ,bullet_direction, muzzle.global_position)

