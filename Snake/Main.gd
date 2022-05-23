extends Node

const SNAKE := 0
const APPLE := 1
const UP := Vector2(0,-1)
const DOWN := Vector2(0,1)
const LEFT := Vector2(-1,0)
const RIGHT := Vector2(1,0)

var apple_position: Vector2
var snake_body := [Vector2(5,10), Vector2(4,10), Vector2(3,10)]
var snake_direction := Vector2(1,0)



func _ready() -> void:
	spawn_apple()
	draw_snake()
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_down") and snake_direction != UP:
		snake_direction = DOWN
	if Input.is_action_just_pressed("ui_up") and snake_direction != DOWN:
		snake_direction = UP
	if Input.is_action_just_pressed("ui_left") and snake_direction != RIGHT:
		snake_direction = LEFT
	if Input.is_action_just_pressed("ui_right") and snake_direction != LEFT:
		snake_direction = RIGHT

func _physics_process(delta: float) -> void:
	is_game_over()

func spawn_apple() -> void:
	randomize()
	var x = randi() % 20
	var y = randi() % 20
	apple_position = Vector2(x,y)
	$SnakeApple.set_cell(x,y,APPLE)

func draw_snake() -> void:
	clear_tiles(SNAKE)
#	for body in snake_body:
#		$SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(8,0))

	for body_index in snake_body.size():
		var body = snake_body[body_index]
		
		# Snake HEAD
		if body_index == 0:
			var head_direction: Vector2 = snake_body[1].direction_to(snake_body[0])
			if head_direction == RIGHT: $SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(2,0))
			if head_direction == LEFT: $SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(3,1))
			if head_direction == UP: $SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(2,1))
			if head_direction == DOWN: $SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(3,0))
		# Snake TAIL
		if body_index == snake_body.size() - 1:
			var tail_direction: Vector2 = snake_body[snake_body.size() - 2].direction_to(snake_body[snake_body.size() - 1])
			if tail_direction == RIGHT: $SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(1,0))
			if tail_direction == LEFT: $SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(0,0))
			if tail_direction == UP: $SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(0,1))
			if tail_direction == DOWN: $SnakeApple.set_cell(body.x, body.y, SNAKE, false, false, false, Vector2(1,1))

		else:
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

func grow_snake() -> void:
	var snake_tail_copy: Vector2 = snake_body[snake_body.size() - 1]
	snake_body.append(snake_tail_copy)

func is_apple_eaten() -> void:
	# Snake_body[0] = snake head
	if apple_position == snake_body[0]:
		spawn_apple()
		grow_snake()

func is_game_over() -> void:
	var head: Vector2 = snake_body[0]
	# Left screen condition
	if head.x > 19 or head.x < 0 or head.y > 19 or head.y < 0:
		restart_game()
	
	# Eats own tail
	for body in snake_body.slice(1, snake_body.size() - 1):
		if body == head:
			restart_game()

func restart_game():
	snake_body = [Vector2(5,10), Vector2(4,10), Vector2(3,10)]
	snake_direction = Vector2(1,0)

func _on_MoveSnakeTick_timeout() -> void:
	move_snake()
	draw_snake()
	is_apple_eaten()
