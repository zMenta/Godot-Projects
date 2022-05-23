extends Node

const SNAKE := 0
const APPLE := 1
const UP_DIRECTION := Vector2(0,-1)
const DOWN_DIRECTION := Vector2(0,1)
const LEFT_DIRECTION := Vector2(-1,0)
const RIGHT_DIRECTION := Vector2(1,0)


var snake_body := [Vector2(5,10), Vector2(4,10), Vector2(3,10)]
var snake_direction := Vector2(1,0)

func _ready() -> void:
	spawn_apple()
	draw_snake()
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_down") and snake_direction != UP_DIRECTION:
		snake_direction = DOWN_DIRECTION
	if Input.is_action_just_pressed("ui_up") and snake_direction != DOWN_DIRECTION:
		snake_direction = UP_DIRECTION
	if Input.is_action_just_pressed("ui_left") and snake_direction != RIGHT_DIRECTION:
		snake_direction = LEFT_DIRECTION
	if Input.is_action_just_pressed("ui_right") and snake_direction != LEFT_DIRECTION:
		snake_direction = RIGHT_DIRECTION

func spawn_apple() -> void:
	randomize()
	var x = randi() % 20
	var y = randi() % 20
	$SnakeApple.set_cell(x,y,APPLE)

func draw_snake() -> void:
	clear_tiles(SNAKE)
	for body in snake_body:
		$SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(8,0))

func move_snake() -> void:
	var body_copy := snake_body.slice(0, snake_body.size() - 2)
	var snake_head: Vector2 = body_copy[0] + snake_direction
	body_copy.insert(0,snake_head)
	snake_body = body_copy
	
func clear_tiles(id: int) -> void:
	var cells: Array = $SnakeApple.get_used_cells_by_id(id)
	for cell in cells:
		$SnakeApple.set_cell(cell.x, cell.y, -1)

func _on_MoveSnakeTick_timeout() -> void:
	move_snake()
	draw_snake()
