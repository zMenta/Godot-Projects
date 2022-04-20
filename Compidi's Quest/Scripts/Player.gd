extends RigidBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var direction : Vector2
var velocity := 0

func _ready() -> void:
	pass
		
func _process(delta: float) -> void:
	
	#Animation
	if linear_velocity.length() > 70:
		$AnimatedSprite.set_animation("jump")
	else:
		$AnimatedSprite.set_animation("rest")
		
	#Controls
	if Input.is_action_just_pressed("m1_click"):
		print(get_local_mouse_position().normalized())
		direction = get_local_mouse_position().normalized()
	if Input.is_action_pressed("m1_click"):
		velocity += 10
		$ProgressBar.value = velocity
	if Input.is_action_just_released("m1_click"):
		linear_velocity += direction * $ProgressBar.value
		velocity = 0	
		$ProgressBar.value = 0
		
	
