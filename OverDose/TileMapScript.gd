extends TileMap


const ZOMBIE_SPAWN_ID := 5


func get_spawn_positions() -> Array:
	return get_used_cells_by_id(ZOMBIE_SPAWN_ID)

