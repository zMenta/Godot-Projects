extends RigidBody2D


signal player_jumped

var direction : Vector2
var velocity := 0
var speed_y := 0
var speed_x := 0


func _ready() -> void:
	connect("player_jumped", owner, "_on_player_jump")


func _process(delta: float) -> void:
	
	#Animation
	if linear_velocity.length() > 70:
		$AnimatedSprite.set_animation("jump")
	else:
		$AnimatedSprite.set_animation("rest")
		
	#Controls
	if Input.is_action_just_pressed("m1_click"):
		direction = get_local_mouse_position().normalized()
	if Input.is_action_pressed("m1_click"):
		velocity += 10
		$ProgressBar.value = velocity
	if Input.is_action_just_released("m1_click"):
		speed_y = direction.y * $ProgressBar.value
		speed_x = direction.x * $ProgressBar.value
		
		linear_velocity += Vector2(0,speed_y)
		emit_signal("player_jumped", speed_x)
		
		velocity = 0	
		$ProgressBar.value = 0

func move(distance: Vector2):
	pass
#	print("cat moved")
#	print(position)
#	var new_position = position + distance
#	self.set_position(new_position) 
