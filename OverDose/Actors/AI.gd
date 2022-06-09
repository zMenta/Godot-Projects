extends Node2D


var movement = null
var actor = null


func initialize(movement_node) -> void:
	movement = movement_node
	
func _physics_process(delta: float) -> void:
	movement.direction = Vector2.RIGHT
