extends Node2D

@export var obstacle: PackedScene
@export var spawn_time_minimum: float = 1.0
@export var spawn_time_maximum: float = 5.0

@onready var timer : Timer = $Timer
@onready var ground_obstacle_postition : Marker2D = $GroundObstaclePosition
@onready var obstacles_node := $Obstacles


func _ready() -> void:
	timer.wait_time = randf_range(spawn_time_minimum, spawn_time_maximum)
	timer.start()
	
# Spawn objects
func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(spawn_time_minimum, spawn_time_maximum)
	
	var new_obstacle : Obstacle = obstacle.instantiate()
	new_obstacle.global_position = ground_obstacle_postition.global_position
	
	# Random Y size for the obstacles
	new_obstacle.scale.y = randf_range(1, 3.5)
	obstacles_node.add_child(new_obstacle)

# Makes all obstacle stop moving and stops spawn timer.
func stop_world() -> void:
	timer.stop()
	var obstacles := obstacles_node.get_children()
	
	for obstacle in obstacles:
		if obstacle is Obstacle:
			obstacle.stop()


func _on_Player_death() -> void:
	stop_world()
