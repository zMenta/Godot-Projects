extends Node2D


signal state_changed(state)


enum States {
	PATROL,
	ENGAGE
}


onready var detection_zone = $DetectionZone0
onready var patrol_timer = $PatrolTimer

var current_state: int = -1 setget set_state
var target = null
var weapon: Weapon = null
var actor: KinematicBody2D = null

# Patrol State
var patrol_origin := Vector2.ZERO
var patrol_location := Vector2.ZERO
export var patrol_range := 100
var actor_velocity := Vector2.ZERO
var reached_patrol_destination := false



func _ready() -> void:
	set_state(States.PATROL)


func _physics_process(delta: float) -> void:
	match current_state:
		States.PATROL:
			if not reached_patrol_destination:
				actor.rotate_towards(patrol_location)
				actor.move_and_slide(actor_velocity)
				if actor.global_position.distance_to(patrol_location) < 3:
					reached_patrol_destination = true
					patrol_timer.start()
				
		States.ENGAGE:
			if target != null and weapon != null:
				actor_velocity = Vector2.ZERO
				actor.rotate_towards(target.global_position)
				var angle_to_target = actor.global_position.direction_to(target.global_position).angle()
				if abs(actor.rotation - angle_to_target) <= 0.1:
					weapon.fire()
					
		# unkown state
		_:
			print("Error: ",self," undefined ai state")


func set_state(new_state: int) -> void:
	if current_state == new_state:
		return
		
	
	if new_state == States.PATROL:
		patrol_origin = global_position
		patrol_timer.start()
	
		
	current_state = new_state
	emit_signal("state_changed", current_state)


func initialize(actor, weapon: Weapon) -> void:
	self.actor = actor
	self.weapon = weapon


func _on_DetectionZone_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		set_state(States.ENGAGE)
		target = body


func _on_DetectionZone_body_exited(body: Node) -> void:
	if target and body == target:
		set_state(States.PATROL)
		target = null


func _on_PatrolTimer_timeout() -> void:
	var random_x = rand_range(-patrol_range, patrol_range)
	var random_y = rand_range(-patrol_range, patrol_range)
	patrol_location = Vector2(random_x, random_y) + patrol_origin
	reached_patrol_destination = false
	actor_velocity = actor.velocity_toward(patrol_location)