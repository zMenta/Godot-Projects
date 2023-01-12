extends PointLight2D

@export var vision_light: PointLight2D

func _process(_delta: float) -> void:

	if vision_light != null:
		vision_light.global_position = get_global_mouse_position()
	global_position = get_global_mouse_position()

