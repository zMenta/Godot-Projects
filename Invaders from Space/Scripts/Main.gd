extends Node


func _process(delta: float) -> void:
	$UfoPath/PathFollow2D.offset += 250 * delta
	
func on_Player_hit():
	print("player got hit!")

func on_Alien_hit():
	print("Alien got hit!")
