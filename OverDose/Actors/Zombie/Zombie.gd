extends KinematicBody2D


onready var ai := $AI
onready var movement := $Movement
onready var hurt_zone := $HurtZone
onready var attack_timer := $AttackTimer
onready var attack_cooldown_timer := $AttackCoolDownTimer
onready var animation_player := $AnimationPlayer


export var health := 100


func _ready() -> void:
	animation_player.play("initialize")
	ai.initialize(movement)


func take_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		death()


func death() -> void:
	animation_player.play("death")
	queue_free()


func _on_BulletHitArea_area_entered(area: Area2D) -> void:
	if area is Bullet:
		animation_player.play("take_damage")
		take_damage(area.damage)


func _on_HurtZone_body_entered(body: Node) -> void:
	if body.has_method("on_zombie_hit"):
		attack_timer.start()


func _on_AttackTimer_timeout() -> void:
	var bodies : Array = hurt_zone.get_overlapping_bodies()
	if bodies.size() > 0:
		attack_timer.start()
		if attack_cooldown_timer.is_stopped():
			var player_index = bodies.find(Player)
			bodies[player_index].on_zombie_hit()
			attack_cooldown_timer.start()
