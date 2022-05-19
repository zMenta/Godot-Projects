extends Node

export (PackedScene) var Ufo
export (PackedScene) var UfoAmi
var score := 0
var seconds := 0
var minutes := 0
var player_alive := true
var enemy_list := []


func _ready():
	randomize()


func spawn_alien():
	var Alien = null
	if randi() % 100 >= 80:
		Alien = UfoAmi.instance()
		Alien.player = $Player
	else:
		Alien = Ufo.instance()
	
	var alien_spawn_path = $AlienSpawnPath/PathFollow2D
	alien_spawn_path.offset = randi()

	Alien.position = alien_spawn_path.position

	enemy_list.append(Alien)
	add_child(Alien)
	Alien.create_new_position()


func on_Player_hit():
	$Player.death()
	player_alive = false
	

func on_Alien_hit(alien):
	score += 1
	$Hud/Score.text = "Kills: " + str(score)
	alien.death()
	enemy_list.erase(alien)


func _on_AlienSpawnTimer_timeout():
	seconds += 1
	if player_alive == true:
		$Hud/Time.text = "Time - " + str(minutes) + " : " + str(seconds)	
	if seconds >= 60:
		minutes += 1
		seconds = 0
	if enemy_list.size() < 30:
		spawn_alien()
