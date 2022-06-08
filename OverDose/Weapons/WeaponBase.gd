extends Node2D


onready var muzzle := $Muzzle
onready var handle := $Handle
onready var cooldown_timer := $FireCooldownTimer


export(PackedScene) var Bullet
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
	GlobalSignals.emit_signal("bullet_fired", Bullet.instance() ,bullet_direction, muzzle.global_position)


func _on_FireCooldownTimer_timeout() -> void:
	can_shoot = true
