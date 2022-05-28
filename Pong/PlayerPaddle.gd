extends "res://Paddle.gd"

export var speed := 300


func _physics_process(delta: float) -> void:
	var velocity := speed * delta
	if Input.is_action_pressed("ui_up"):
		position.y -= velocity
	if Input.is_action_pressed("ui_down"):
		position.y += velocity
	if Input.is_action_pressed("ui_right"):
		position.x += velocity
	if Input.is_action_pressed("ui_left"):
		position.x -= velocity
	
