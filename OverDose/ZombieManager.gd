extends Node2D


signal round_changed(round_value)


export (PackedScene) var Zombie 


onready var round_transition_timer := $RoundTransitionTimer


export var round_zombie_cap := 48


var current_round := 1
var zombie_quantity : int = 12
onready var round_zombie_quantity := zombie_quantity
var current_zombie_quantity := 0
var tilemap : TileMap = null setget set_tilemap
var zombie_spawns_locations : Array = []


func spawn_zombie(location: Vector2) -> void:
	var zombie_instance = Zombie.instance()
	# Is multiplied by 32, because it's the tile size (32x32)
	# plus half of the tile size (16) to spawn on the center.
	zombie_instance.position = (location * 32) + Vector2(16,16)
	zombie_instance.connect("zombie_died", self, "zombie_died")
	
	add_child(zombie_instance)


func set_tilemap(new_tilemap: TileMap) -> void:
	tilemap = new_tilemap
	if tilemap.has_method("get_spawn_positions"):
		zombie_spawns_locations = tilemap.get_spawn_positions()


func zombie_died() -> void:
	current_zombie_quantity -= 1
	if current_zombie_quantity < 0:
		current_zombie_quantity = 0


func next_round() -> void:
	round_transition_timer.start()
	current_round += 1
	zombie_quantity += 1 + current_round/2
	round_zombie_quantity = zombie_quantity
	emit_signal("round_changed", current_round)


func _on_SpawnTimer_timeout() -> void:
	var locations_size = zombie_spawns_locations.size()
	
	if round_transition_timer.is_stopped():
		if locations_size > 0 and current_zombie_quantity < round_zombie_cap and round_zombie_quantity > 0:
			spawn_zombie(zombie_spawns_locations[randi() % locations_size])
			current_zombie_quantity += 1
			round_zombie_quantity -= 1
		elif round_zombie_quantity <= 0 and current_zombie_quantity <= 0 :
				next_round()	

