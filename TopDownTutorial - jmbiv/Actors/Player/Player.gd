extends KinematicBody2D
class_name Player

signal player_fired_gun(bullet, position, direction)

export var speed := 150

onready var health = $Health
onready var weapon = $Weapon


func _ready() -> void:
	health.connect("health_depleted", self, "death")
	weapon.connect("weapon_fired", self, "shoot")


func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	if 	Input.is_action_pressed("ui_left"): direction.x = -1
	if 	Input.is_action_pressed("ui_right"): direction.x = 1
	if 	Input.is_action_pressed("ui_up"): direction.y = -1
	if 	Input.is_action_pressed("ui_down"): direction.y = 1
	
	direction = direction.normalized()
	move_and_slide(direction * speed)
	look_at(get_global_mouse_position())
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"): weapon.fire()
	

func shoot(bullet: Bullet, position: Vector2, direction: Vector2) -> void:
	emit_signal("player_fired_gun", bullet, position, direction)


func handle_hit() -> void:
	health.health_value -= 20
	

func death() -> void:
	queue_free()
	



