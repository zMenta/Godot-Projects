extends Spatial

export(PackedScene) var mob_scene = preload("res://Mob.tscn")

func _ready() -> void:
	randomize()

func _on_SpawnTimer_timeout() -> void:
	var mob = mob_scene.instance() as Mob
	
	var mob_spawn_location := $SpawnPath/SpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	
	add_child(mob)
	mob.initialize($Player.transform.origin, mob_spawn_location.translation)
