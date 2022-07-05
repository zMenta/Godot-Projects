extends Control

var is_paused = false setget set_pause


func set_pause(value):
	is_paused = value
	get_tree().paused = is_paused
