extends RigidBody


export var rolling_force := 30


func _ready() -> void:
	$CameraPivot.set_as_toplevel(true)


func _physics_process(delta: float) -> void:
	_lerp_camera_position()
	
	var force_delta = rolling_force * delta
	
	if Input.is_action_pressed("foward"):
		angular_velocity.x -= force_delta
	if Input.is_action_pressed("backwards"):
		angular_velocity.x += force_delta
	if Input.is_action_pressed("left"):
		angular_velocity.z += force_delta
	if Input.is_action_pressed("right"):
		angular_velocity.z -= force_delta


func _lerp_camera_position():
	var old_position = $CameraPivot.global_transform.origin
	var ball_position = self.global_transform.origin
	
	$CameraPivot.global_transform.origin = lerp(old_position, ball_position, 0.03)
	
