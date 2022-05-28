extends Area2D

export var speed := 200
export var speed_limit := 1000
var direction := Vector2(1,1)
onready var ball_rect: Vector2 = $ColorRect.rect_size


func _physics_process(delta: float) -> void:
	position += speed * delta * direction

func increase_speed(amount: int) -> void:
	speed += amount
	if speed >= speed_limit:
		speed = speed_limit


