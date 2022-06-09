extends Node2D

onready var line2d := $PathFindingLine

var movement = null
var direction := Vector2.ZERO
var navigation: Navigation2D = null
var player: KinematicBody2D = null


func _ready() -> void:
	yield(get_tree(), "idle_frame")
	if get_tree().get_nodes_in_group("navigation").size() > 0:
		navigation = get_tree().get_nodes_in_group("navigation")[0]
		
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]


func _physics_process(delta: float) -> void:
	line2d.global_position = Vector2.ZERO
	if navigation != null and player != null:
		update_direction()
		movement.direction = direction
	

func initialize(movement_node) -> void:
	movement = movement_node


func update_direction() -> void:
	var path := navigation.get_simple_path(global_position, player.global_position, false)
	line2d.points = path
	if path.size() > 0:
		direction = global_position.direction_to(path[1])
