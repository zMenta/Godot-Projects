extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_point_made():
	print("point made!")
	
	
	$Player.set_sleeping(true)
#	get_tree().call_group("blocks", "move", distance)

func _on_player_jump(speed_x):
	print("speed_x:", speed_x)
	var distance := Vector2(speed_x,0)
	get_tree().call_group("blocks", "move", distance)
#	$Block.move(Vector2(speed_x,0))
