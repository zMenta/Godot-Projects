extends KinematicBody2D


onready var health = $Health

func _ready() -> void:
	health.connect("health_depleted", self, "death")


func handle_hit() -> void:
	health.health_value -= 20
	print(health.health_value)
	

func death() -> void:
	queue_free()
