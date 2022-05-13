extends Area2D

export (PackedScene) var Bullet 


func _on_ShootTimer_timeout() -> void:
	shoot()


func shoot() -> void:
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.connect("player_hit", owner, "on_Player_hit")
	bullet.transform = $Muzzle.global_transform
