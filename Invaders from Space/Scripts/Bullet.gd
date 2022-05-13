extends Area2D

export var speed := 600

signal alien_hit(alien)

func _physics_process(delta: float) -> void:
	position += transform.x * delta * speed
	

func _on_Bullet_body_entered(body: Node) -> void:
	queue_free()


#Aliens are AREA2D
func _on_Bullet_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("aliens"):
		emit_signal("alien_hit", area)
	queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

