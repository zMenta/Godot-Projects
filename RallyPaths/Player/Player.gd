extends Spatial


onready var ball = $Ball
onready var car = $hatchbackSports
onready var ground_ray = $hatchbackSports/GroundRayCast

export var acceleration := 60
export var steering := 21.0
export var turn_speed := 5
export var turn_stop_limit := 0.75

#var sphere_offset := Vector3(0, -1.0, 0)
var speed_input := 0
var rotate_input := 0


func _ready() -> void:
	ground_ray.add_exception(ball)


func _physics_process(delta: float) -> void:
	car.transform.origin = ball.transform.origin 
	# Accelerate ball based on the car foward direction.
	ball.add_central_force(-car.global_transform.basis.z * speed_input)
	
	
func _process(delta: float) -> void:
	if not ground_ray.is_colliding():
		return
		
	speed_input = 0
	speed_input += Input.get_action_strength("accelerate")
	speed_input -= Input.get_action_strength("brake")
	speed_input *= acceleration
	
	rotate_input = 0
	rotate_input += Input.get_action_strength("steer_left")
	rotate_input -= Input.get_action_strength("steer_right")
	rotate_input *= steering
	
	
	#rotate car
	if ball.linear_velocity.length() > turn_stop_limit:
		var new_basis = car.global_transform.basis.rotated(car.global_transform.basis.y, deg2rad(rotate_input))
		car.global_transform.basis = car.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car.global_transform = car.global_transform.orthonormalized()
	
	
