extends Area2D

export (PackedScene) var Bullet 

var screen := OS.get_window_safe_area().size
var speed := 150
var velocity := Vector2.ZERO
onready var new_position := position


func _physics_process(delta):
	position.x = clamp(position.x, 0+60, screen.x-60)
	position.y = clamp(position.y, 0, screen.y)
	if new_position != position:
		var direction = position.direction_to(new_position)
		var lenght = position.distance_to(new_position)
		if lenght > 3:
			velocity = direction * speed * delta
		else:
			velocity = Vector2.ZERO
		position += velocity
		

func create_new_position():
	new_position = Vector2(rand_range(0,screen.x - 60), rand_range(0,screen.y - 150))


func death():
	queue_free()


func shoot() -> void:
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.connect("player_hit", owner, "on_Player_hit")
	bullet.transform = $Muzzle.global_transform
	create_new_position()


func _on_ShootTimer_timeout() -> void:
	shoot()
