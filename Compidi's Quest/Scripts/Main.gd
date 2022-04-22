extends Node

func _on_point_made():
	print("point made!")
	
	$Player.set_sleeping(true)

onready var player = $Player

func _physics_process(delta: float) -> void:
	print(player.linear_velocity)
		
	

func _on_player_jump(speed_x) -> float:
	return speed_x
