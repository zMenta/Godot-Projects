extends Area2D

signal hit

export var speed := 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Player Movement and Animation logic
func _process(delta: float):
	var direction := Vector2.ZERO 
	var velocity := Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	
	if direction.length() > 0:
		velocity = direction.normalized() * speed * delta
		$AnimatedSprite.play()
		
		#Checks animation direction
		if velocity.x != 0:
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_v = velocity.y > 0 
			$AnimatedSprite.flip_h = velocity.x < 0
		elif velocity.y != 0:
			$AnimatedSprite.animation = "up"
			$AnimatedSprite.flip_v = velocity.y > 0
	
	if not direction.length() > 0:
		$AnimatedSprite.stop()
	
	position += velocity
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func start(player_position: Vector2):
	position = player_position
	show()
	$CollisionShape2D.disabled = false


# warning-ignore:unused_argument
func _on_Player_body_entered(body: Node):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled",true)
