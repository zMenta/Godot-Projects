extends Node2D


signal state_changed(state)


enum States {
	PATROL,
	ENGAGE
}


onready var detection_zone = $DetectionZone0

var current_state: int = States.PATROL setget set_state
var target = null
var weapon: Weapon = null
var actor = null


func _physics_process(delta: float) -> void:
	match current_state:
		States.PATROL:
			pass
		States.ENGAGE:
			if target != null and weapon != null:
				weapon.fire()
				actor.rotation = actor.global_position.direction_to(target.global_position).angle()
		_:
			print("Error: ",self," undefined ai state")


func set_state(new_state: int) -> void:
	if current_state == new_state:
		return
		
	current_state = new_state
	emit_signal("state_changed", current_state)


func initialize(actor, weapon: Weapon) -> void:
	self.actor = actor
	self.weapon = weapon


func _on_DetectionZone_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		set_state(States.ENGAGE)
		target = body
