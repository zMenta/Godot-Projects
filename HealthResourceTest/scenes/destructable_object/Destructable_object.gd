extends Node2D
class_name DestructableObject

export(Resource) var health


func _ready() -> void:
	_change_health(health.health)
	health.connect("died", self, "_on_Health_depleted")


func _change_health(new_value: int) -> void:
	$Button/Label.text = "Health: " + str(new_value)


func _on_Button_pressed() -> void:
	health.take_damage()
	_change_health(health.health)


func _on_Health_depleted() -> void:
	print(str(self) + " -> died")
