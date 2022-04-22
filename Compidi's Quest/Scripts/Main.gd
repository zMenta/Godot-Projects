extends Node

export(PackedScene) var block_scene

func _ready() -> void:
	randomize()


func spawn_block():
	var block = block_scene.instance()
	var block_spawn_location = $BlockPosition
	var y_random_position := int(rand_range(-100, 100))
	var x_random_position := int(rand_range(200, 300))
	
	block_spawn_location.position += Vector2(x_random_position, y_random_position)
	block.position = block_spawn_location.position
	
	print(block.position)
	
	block.connect_to_owner(self)
	add_child(block)

func _on_point_made():
	spawn_block()
	print("point made!")
	$Player.set_sleeping(true)
	
