extends Spatial

export(PackedScene) var mob_scene = preload("res://Mob.tscn")

var points := 0

func _ready() -> void:
	randomize()

func _on_SpawnTimer_timeout() -> void:
	var mob = mob_scene.instance() as Mob
	
	var mob_spawn_location := $SpawnPath/SpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	
	add_child(mob)
	mob.connect("squashed", self, "_on_Mob_squashed")
	mob.initialize($Player.transform.origin, mob_spawn_location.translation)

func _on_Mob_squashed() -> void:
	points += 1
	$UI/Label.text = "Points: %s" % points

func _on_Player_died() -> void:
	$SpawnTimer.stop()
