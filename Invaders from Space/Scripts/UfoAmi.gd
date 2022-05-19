extends Area2D

export (PackedScene) var Bullet 

onready var screen := get_viewport().get_visible_rect().size
var speed := 75
var velocity := Vector2.ZERO
onready var new_position := position
var player = null


func _physics_process(delta):
	if player:
		var player_position = player.position
		$CannonPivot.look_at(player_position)
	
	if new_position != position:
		var direction = position.direction_to(new_position)
		var lenght = position.distance_to(new_position)
		if lenght > 3:
			velocity = direction * speed * delta
		else:
			velocity = Vector2.ZERO
		position += velocity
		

func create_new_position():
	new_position = Vector2(rand_range(0,screen.x - 60), rand_range(0,screen.y * 0.6))


func death():
	queue_free()


func shoot() -> void:
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.connect("player_hit", get_parent(), "on_Player_hit")
	bullet.transform = $CannonPivot/Muzzle.global_transform
	create_new_position()


func _on_ShootTimer_timeout() -> void:
	shoot()
