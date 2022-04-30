extends Node


func _process(delta: float) -> void:
	$UfoPath/PathFollow2D.offset += 250 * delta
