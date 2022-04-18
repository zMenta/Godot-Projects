extends Node

export(PackedScene) var mob_scene

var score: int 

func _ready():
	randomize()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$MusicLoop.stop()
	$DeathSound.play()


func new_game():
	get_tree().call_group("mobs", "queue_free")
	$MusicLoop.play()
	
	score = 0
	$StartGameTimer.start()
	$Player.start($StartPostion.position)
	
	# HUD Updates
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartGameTimer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()

# Mob spawner
func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.offset = randi()
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction
	direction += rand_range(-PI / 4, PI / 4)

	mob.position = mob_spawn_location.position
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(mob.rotation)
	
	# Spawns the mob. Addind mob scene to the Main scene
	add_child(mob)
