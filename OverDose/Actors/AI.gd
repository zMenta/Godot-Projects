extends Node2D

onready var line2d := $PathFindingLine
onready var line_of_sight := $LineOfSightPivot/LineOfSight
onready var pivot := $LineOfSightPivot

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
	if navigation != null and player != null:
		pivot.look_at(player.global_position)
		
		line2d.global_position = Vector2.ZERO
		movement.direction = direction
	

func initialize(movement_node) -> void:
	movement = movement_node


func update_direction() -> void:
	var path := []
	if has_player_sight():
		path = navigation.get_simple_path(global_position, player.global_position, true)
	else:
		path = navigation.get_simple_path(global_position, player.global_position, false)
	
	line2d.points = path
	if path.size() > 0:
		direction = global_position.direction_to(path[1])


func has_player_sight() -> bool:
	if line_of_sight.get_collider() is Player:
		return true
	else:
		return false


func _on_CalculateNewPathTimer_timeout() -> void:
	update_direction()
