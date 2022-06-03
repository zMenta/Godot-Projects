extends KinematicBody2D


onready var health = $Health
onready var weapon = $Weapon
onready var ai = $AI

func _ready() -> void:
	health.connect("health_depleted", self, "death")
	ai.initialize(self, weapon)


func handle_hit() -> void:
	health.health_value -= 20
	

func death() -> void:
	queue_free()
