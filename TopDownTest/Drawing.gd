extends Node2D

export var ball_color := Color(0.3,0.2,0,1)
export var color := Color(0.2,0.1,0.2,1)
export var size := 18
export var ball_size := 8

func _process(delta: float) -> void:
#	var mouse = get_global_mouse_position()
#	move(delta, mouse)
#	$End.position = Vector2(mouse.x, -mouse.y)
	update()

func play_animation():
	$AnimationPlayer.play("Line animation")

func stop_animation():
	$End.position = $End.position.linear_interpolate($Start.position, 0.05)
	$End2.position = $End2.position.linear_interpolate($Start2.position, 0.05)
	$AnimationPlayer.stop(false)

func _draw() -> void:
	draw_line($Start.position, $End.position, color, size)
	draw_circle($End.position, ball_size, color)
	
	draw_line($Start2.position, $End2.position, color, size)
	draw_circle($End2.position, ball_size, color)

#
#func move(delta, mouse):
#	$End.position = $Start.position.linear_interpolate(mouse, delta * FOLLOW_SPEED)
