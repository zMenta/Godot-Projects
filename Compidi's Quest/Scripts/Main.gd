extends Node

export(PackedScene) var block_scene
var score: int


func _ready() -> void:
	randomize()
	new_game()


func _process(delta) -> void:
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func new_game() -> void:
	score = 0
	var first_block = spawn_block()
	first_block.is_point_obtainable = false
	spawn_block()
	spawn_block()
	

func spawn_block():
	var block = block_scene.instance()
	var block_spawn_location = $BlockPosition
	var y_random_position := int(rand_range(-100, 100))
	var x_random_position := int(rand_range(250, 300))
	
	block.position = block_spawn_location.position
	block_spawn_location.position += Vector2(x_random_position, y_random_position)
	
	block.connect_to_target(self)
	add_child(block)
	return block


func _on_point_made():
	spawn_block()
	score += 1
	$Player/HUD.update_score_label(score)
