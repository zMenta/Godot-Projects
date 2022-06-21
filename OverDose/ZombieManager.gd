extends Node2D


export (PackedScene) var Zombie 


var zombie_quantity := 10
var current_zombie_quantity := 0
var max_current_zombies := 4
var tilemap : TileMap = null setget set_tilemap
var zombie_spawns_locations : Array = []


func spawn_zombie(x: int, y: int) -> void:
	var zombie_instance = Zombie.instance()
	zombie_instance.position = Vector2(x,y)
	
	add_child(zombie_instance)


func set_tilemap(new_tilemap: TileMap) -> void:
	tilemap = new_tilemap
	if tilemap.has_method("get_spawn_positions"):
		zombie_spawns_locations = tilemap.get_spawn_positions()
