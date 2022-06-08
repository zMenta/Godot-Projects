extends Node2D
class_name Weapon


onready var muzzle := $Muzzle
onready var handle := $Handle
onready var cooldown_timer := $FireCooldownTimer


export(PackedScene) var Bullet
export var bullet_damage := 10
export var bullet_direction := Vector2.ZERO
export var fire_cooldown := 0.3


func _ready() -> void:
	bullet_direction = handle.global_position.direction_to(muzzle.global_position)
	cooldown_timer.set_wait_time(fire_cooldown)


func fire() -> void:
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
		var bullet_instance = Bullet.instance()
		GlobalSignals.emit_signal("bullet_fired", bullet_instance ,bullet_direction, muzzle.global_position)

