extends CharacterBody2D

const SPEED = 300.0


func _enter_tree() -> void:
	set_multiplayer_authority(str(name).to_int())


func _ready() -> void:
	if not is_multiplayer_authority() : return

	_set_player_name()


# @rpc(any_peer, call_local)
func _set_player_name() -> void:
	$Label.text = "Player " + name


func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority() : return

	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")

	if direction_x or direction_y:
		velocity.x = direction_x * SPEED
		velocity.y = direction_y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
