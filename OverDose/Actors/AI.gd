extends Node2D


var movement = null
var actor = null
var navigation: Navigation2D = null


func initialize(movement_node) -> void:
	movement = movement_node


func _ready() -> void:
	if get_tree().get_nodes_in_group("navigation").size() > 0:
		navigation = get_tree().get_nodes_in_group("navigation")[0]


func _physics_process(delta: float) -> void:
	if navigation != null:
		movement.direction = Vector2.RIGHT
	
	
func update_direction() -> void:
	pass
#	var path := navigation.get_simple_path(global_position, ) 
