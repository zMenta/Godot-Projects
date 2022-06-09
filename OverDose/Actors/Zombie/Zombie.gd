extends KinematicBody2D


onready var ai := $AI
onready var movement := $Movement


func _ready() -> void:
	ai.initialize(movement)
