extends Area2D


export var speed := 500


func _physics_process(delta: float) -> void:
	position += transform.y * delta * speed
	

func _on_AlienBullet_body_entered(body: Node) -> void:
	queue_free()
	print("Body entered")
