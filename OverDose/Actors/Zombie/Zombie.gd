extends KinematicBody2D


onready var ai := $AI
onready var movement := $Movement


export var health := 100


func _ready() -> void:
	ai.initialize(movement)


func take_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		death()


func death() -> void:
	queue_free()


func _on_BulletHitArea_area_entered(area: Area2D) -> void:
	if area is Bullet:
		take_damage(area.damage)


func _on_HurtZone_body_entered(body: Node) -> void:
	print("player entered")
