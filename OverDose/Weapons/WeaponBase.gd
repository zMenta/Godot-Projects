extends Node2D
class_name Weapon


onready var muzzle := $Muzzle
onready var handle := $Handle
onready var cooldown_timer := $FireCooldownTimer


export(PackedScene) var Bullet
export var bullet_damage := 10
export var bullet_direction := Vector2.ZERO


func _ready() -> void:
	bullet_direction = handle.global_position.direction_to(muzzle.global_position)


func fire() -> void:
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
		GlobalSignals.emit_signal("bullet_fired", Bullet.instance() ,bullet_direction, muzzle.global_position)

