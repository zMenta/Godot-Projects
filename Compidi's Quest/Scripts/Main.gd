extends Node

func _on_point_made():
	print("point made!")
	
	
	$Player.set_sleeping(true)
#	get_tree().call_group("blocks", "move", distance)

func _on_player_jump(speed_x) -> float:
	return speed_x
