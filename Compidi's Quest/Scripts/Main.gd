extends Node

export(PackedScene) var block_scene

func _ready() -> void:
	randomize()

func spawn_block():
	var block = block_scene.instance()	
	var block_spawn_location = $BlockPath/BlockSpawnPosition
	
	block_spawn_location.offset = randi()
	block.position = block_spawn_location.position

	add_child(block)

func _on_point_made():
	spawn_block()
	print("point made!")
	$Player.set_sleeping(true)
	
