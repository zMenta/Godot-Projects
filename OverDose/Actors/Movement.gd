extends Node2D


onready var animation_player := $AnimationPlayer
onready var actor: KinematicBody2D = get_owner()


export var speed := 120
export var acceleration := 0.2
export var friction := 0.2


var velocity := Vector2.ZERO
var direction := Vector2.ZERO 



func _physics_process(delta: float) -> void:
	print(actor)
	if actor == null or actor == KinematicBody2D:
		print("returned")
		return

	if direction.length() > 0:
		velocity = lerp(velocity, direction * speed, acceleration)
		animation_player.play("Moving")
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		animation_player.play("Idle")

	velocity = actor.move_and_slide(velocity)


	
