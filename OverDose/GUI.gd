extends CanvasLayer


onready var current_ammo_label := $MarginContainer/Rows/Row3/Ammo/VBoxContainer/HBoxContainer/CurrentAmmo
onready var clip_size_label := $MarginContainer/Rows/Row3/Ammo/VBoxContainer/HBoxContainer/ClipSize
onready var total_ammo_label := $MarginContainer/Rows/Row3/Ammo/VBoxContainer/MarginContainer/HBoxContainer2/CenterContainer/TotalAmmo


var player = null



func set_current_ammo_text(new_current_ammo: int) -> void:
	current_ammo_label.text = str(new_current_ammo)
	

func set_clip_size_text(new_clip_size: int) -> void:
	clip_size_label.text = str(new_clip_size)
	

func set_total_ammo_text(new_total_ammo: int) -> void:
	total_ammo_label.text = str(new_total_ammo)
