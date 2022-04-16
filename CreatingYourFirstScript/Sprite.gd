extends Sprite

var speed = 400
var angular_speed = PI

func _process(delta):
	rotation += angular_speed * delta
	var velocity = Vector2.RIGHT.rotated(rotation) * speed

	position += velocity * delta

#	var direction = 0
#	var velocity = Vector2.ZERO
#	if Input.is_action_pressed("ui_left"):
#		direction += -1
#	if Input.is_action_pressed("ui_right"):
#		direction += 1
#	if Input.is_action_pressed("ui_up"):
#		velocity = Vector2.UP.rotated(rotation) * speed
#	if Input.is_action_pressed("ui_down"):
#		velocity = Vector2.DOWN.rotated(rotation) * speed/2
#	rotation += angular_speed * direction * delta	
#	position += velocity * delta


func _ready():
	var timer = get_node("Timer")
	timer.connect("timeout", self, "_on_Timer_timeout")
	
func _on_Timer_timeout():
	visible = not visible


func _on_Button_pressed():
	set_process(not is_processing())
