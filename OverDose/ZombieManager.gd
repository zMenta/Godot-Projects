extends Node2D


export (PackedScene) var Zombie 


onready var round_transition_timer := $RoundTransitionTimer


var zombie_quantity := 10
var current_zombie_quantity := 0
var max_current_zombies := 4
var tilemap : TileMap = null setget set_tilemap
var zombie_spawns_locations : Array = []


func spawn_zombie(location: Vector2) -> void:
	var zombie_instance = Zombie.instance()
	# Is multiplied by 32, because it's the tile size (32x32)
	# plus half of the tile size (16) to spawn on the center.
	zombie_instance.position = (location * 32) + Vector2(16,16)
	
	add_child(zombie_instance)


func set_tilemap(new_tilemap: TileMap) -> void:
	tilemap = new_tilemap
	if tilemap.has_method("get_spawn_positions"):
		zombie_spawns_locations = tilemap.get_spawn_positions()


func _on_SpawnTimer_timeout() -> void:
	var locations_size = zombie_spawns_locations.size()
	if locations_size > 0 and round_transition_timer.is_stopped():
		spawn_zombie(zombie_spawns_locations[randi() % locations_size])
