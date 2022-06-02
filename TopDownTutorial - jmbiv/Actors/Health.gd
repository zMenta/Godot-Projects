extends Node2D

signal health_depleted

export var max_health := 100
export var health_value := 100 setget set_health


func set_health(new_value):
	health_value = new_value
	if health_value <= 0:
		health_value = 0
		emit_signal("health_depleted")
