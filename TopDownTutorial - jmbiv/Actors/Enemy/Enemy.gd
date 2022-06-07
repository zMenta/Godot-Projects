extends KinematicBody2D


onready var health = $Health
onready var weapon = $Weapon
onready var ai = $AI

func _ready() -> void:
	health.connect("health_depleted", self, "death")
	ai.initialize(self, weapon)


func rotate_towards(location: Vector2, weight := 0.1):
	rotation = lerp(rotation, global_position.direction_to(location).angle(), weight)


func handle_hit() -> void:
	health.health_value -= 20
	

func death() -> void:
	queue_free()
