extends Node


#func _process(delta: float) -> void:
#	$UfoPath/PathFollow2D.offset += 250 * delta
	
func on_Player_hit():
	$Player.death()

func on_Alien_hit(alien):
	alien.death()
