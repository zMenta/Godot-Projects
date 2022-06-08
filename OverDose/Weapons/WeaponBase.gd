extends Node2D

signal weapon_fired(bullet_direction, bullet_damage)

onready var muzzle := $Muzzle
onready var handle := $Handle
onready var cooldown_timer := $FireCooldownTimer


export(PackedScene) var bullet
export var bullet_damage := 10
export var bullet_direction := Vector2.ZERO
export var fire_cooldown := 0.3


var can_shoot := true


func _ready() -> void:
	bullet_direction = handle.global_position.direction_to(muzzle.global_position)
	cooldown_timer.set_wait_time(fire_cooldown)


func fire() -> void:
	cooldown_timer.start()
	can_shoot = false
	emit_signal("weapon_fired", bullet_direction, bullet_damage)


func _on_FireCooldownTimer_timeout() -> void:
	can_shoot = true
