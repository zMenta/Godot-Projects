extends Area2D


export var speed := 500


func _physics_process(delta: float) -> void:
	position += transform.y * delta * speed
	

func _on_AlienBullet_body_entered(body: Node) -> void:
	queue_free()


func _on_AlienBullet_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	queue_free()
