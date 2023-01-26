extends CharacterBody2D
class_name Player

signal health_changed(new_value)

@export var bomb : PackedScene

@onready var animation := $AnimationPlayer
@onready var ray := $RayCast2D
@onready var health_label := $LabelHealth

const SPEED = 300.0

var health : int = 3
func _enter_tree() -> void: set_multiplayer_authority(str(name).to_int())


func _ready() -> void:
	if not is_multiplayer_authority() : return

	health_label.text = str(health)
	$Camera2D.current = true
	_set_player_name()


func _set_player_name() -> void:
	$Label.text = "Player " + name


func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority() : return

	if Input.is_action_just_pressed("ui_accept"):
		happy.rpc()

	if Input.is_action_just_pressed("bomb"):
		create_bomb.rpc()

	if Input.is_action_just_pressed("click"):
		var collider = ray.get_collider()
		if collider is Player:
			collider.angry.rpc()

	ray.rotation = global_position.angle_to_point(get_global_mouse_position()) + deg_to_rad(-90)

	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")

	if direction_x or direction_y:
		velocity.x = direction_x * SPEED
		velocity.y = direction_y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

@rpc(call_local)
func create_bomb() -> void:
	var b = bomb.instantiate()
	b.global_position = self.global_position
	get_parent().add_child(b)


@rpc(call_local)
func happy() -> void:
	animation.play("happy")


@rpc(any_peer, call_local)
func angry() -> void:
	health -= 1
	if health <= 0:
		global_position = Vector2()
		health = 3

	health_label.text = str(health)
	health_changed.emit(health)
	animation.play("angry")
