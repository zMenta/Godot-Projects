extends KinematicBody
class_name Mob

signal squashed

export var min_speed := 10.0
export var max_speed := 18.0

var velocity := Vector3.ZERO

func _physics_process(_delta: float) -> void:
	move_and_slide(velocity)


func squash() -> void:
	emit_signal("squashed")
	queue_free()


func initialize(player_position: Vector3, start_position: Vector3 ) -> void:
	translation = start_position
	look_at(player_position, Vector3.UP)
	rotate_y(rand_range(-PI / 4, PI / 4)) # 90 degrees range
	
	var speed = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	

func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
