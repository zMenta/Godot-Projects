extends Node2D

signal weapon_fired(bullet_direction, bullet_damage)

onready var muzzle := $Muzzle
onready var handle := $Handle


export(PackedScene) var bullet
export var bullet_damage := 10
export var bullet_direction := Vector2.ZERO


func _ready() -> void:
	bullet_direction = handle.global_position.direction_to(muzzle.global_position)


func fire() -> void:
	emit_signal("weapon_fired", bullet_direction, bullet_damage)
