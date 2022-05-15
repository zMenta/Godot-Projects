extends Node

export (PackedScene) var Ufo
var score := 0

func _ready():
	randomize()


#func _process(delta: float) -> void:
#	pass

func spawn_alien():
	var Alien = Ufo.instance()

	var alien_spawn_path = $AlienSpawnPath/PathFollow2D
	alien_spawn_path.offset = randi()

	Alien.position = alien_spawn_path.position

	add_child(Alien)
	Alien.create_new_position()


func on_Player_hit():
	$Player.death()


func on_Alien_hit(alien):
	score += 1
	$Hud/Score.text = str(score)
	alien.death()


func _on_AlienSpawnTimer_timeout():
	spawn_alien()
