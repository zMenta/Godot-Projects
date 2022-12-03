extends Resource
class_name HealthResource

signal died

export var health := 100


func take_damage() -> void:
	health -= 20
	if health <= 0:
		emit_signal("died")
