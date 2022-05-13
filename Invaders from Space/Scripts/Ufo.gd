extends Area2D

export (PackedScene) var Bullet 

var screen = OS.get_window_safe_area().size

func _ready():
	print(screen)

func _physics_process(delta):
	position.x = clamp(position.x, 0, screen.x)
	position.y = clamp(position.y, 0, screen.y)


func death():
	queue_free()


func shoot() -> void:
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.connect("player_hit", owner, "on_Player_hit")
	bullet.transform = $Muzzle.global_transform


func _on_ShootTimer_timeout() -> void:
	shoot()
