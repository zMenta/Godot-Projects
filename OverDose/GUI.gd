extends CanvasLayer


onready var current_ammo_label := $MarginContainer/Rows/Row3/Ammo/VBoxContainer/HBoxContainer/CurrentAmmo
onready var clip_size_label := $MarginContainer/Rows/Row3/Ammo/VBoxContainer/HBoxContainer/ClipSize
onready var total_ammo_label := $MarginContainer/Rows/Row3/Ammo/VBoxContainer/MarginContainer/HBoxContainer2/CenterContainer/TotalAmmo


var player_inventory = null
var player_current_weapon : Weapon = null


func initialize(player: Player) -> void:
	player_inventory = player.inventory
	player_inventory.connect("weapon_changed", self, "set_player_current_weapon")
	set_player_current_weapon()


func set_player_current_weapon(inventory = player_inventory) -> void:
	player_current_weapon = inventory.current_weapon
	set_clip_size_text(player_current_weapon.magazine_size)
	set_current_ammo_text(player_current_weapon.current_magazine_bullet_count)
	set_total_ammo_text(player_current_weapon.current_max_ammo)
	if not player_current_weapon.is_connected("current_magazine_ammo_changed", self, "set_current_ammo_text"):
		player_current_weapon.connect("current_magazine_ammo_changed", self, "set_current_ammo_text")
	if not player_current_weapon.is_connected("max_ammo_changed", self, "set_total_ammo_text"):
		player_current_weapon.connect("max_ammo_changed", self, "set_total_ammo_text")
	


func set_current_ammo_text(new_current_ammo: int) -> void:
	current_ammo_label.text = str(new_current_ammo)
	

func set_clip_size_text(new_clip_size: int) -> void:
	clip_size_label.text = str(new_clip_size)
	

func set_total_ammo_text(new_total_ammo: int) -> void:
	total_ammo_label.text = str(new_total_ammo)
