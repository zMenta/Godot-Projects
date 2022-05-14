extends Area2D

export (PackedScene) var Bullet 

var screen := OS.get_window_safe_area().size
var speed := 100
var velocity := Vector2.ZERO
onready var new_position := position


func _physics_process(delta):
	position.x = clamp(position.x, 0+60, screen.x-60)
	position.y = clamp(position.y, 0, screen.y)
	if new_position != position:
		var direction = position.direction_to(new_position)
		var lenght = (position - new_position).length()
		if lenght > 1:
			velocity = direction * speed * delta
		else:
			velocity = Vector2.ZERO
		position += velocity
		


func death():
	queue_free()


func shoot() -> void:
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.connect("player_hit", owner, "on_Player_hit")
	bullet.transform = $Muzzle.global_transform


func _on_ShootTimer_timeout() -> void:
	shoot()
