extends Node

func _on_point_made():
	print("point made!")
	$Player.set_sleeping(true)
	

func _on_player_jump(speed_x) -> float:
	return speed_x
