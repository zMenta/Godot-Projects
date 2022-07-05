extends CanvasLayer


onready var current_ammo_label := $MarginContainer/Rows/Row3/VBoxContainer/HBoxContainer/Ammo/VBoxContainer/HBoxContainer/CurrentAmmo
onready var total_ammo_label := $MarginContainer/Rows/Row3/VBoxContainer/HBoxContainer/Ammo/VBoxContainer/HBoxContainer/TotalAmmo
onready var current_round_label := $MarginContainer/Rows/Row1/CurrentRound
onready var money_label := $MarginContainer/Rows/Row3/VBoxContainer/MoneyContainer/HBoxContainer/Money
onready var weapon1 := $MarginContainer/Rows/Row3/VBoxContainer/HBoxContainer/WeaponContainer/ColorRect/VBoxContainer/Weapon1
onready var weapon2 := $MarginContainer/Rows/Row3/VBoxContainer/HBoxContainer/WeaponContainer/ColorRect/VBoxContainer/Weapon2


var player_inventory = null
var player_current_weapon : Weapon = null


func initialize(player: Player, zombie_manager) -> void:
	player_inventory = player.inventory
	player_inventory.connect("weapon_changed", self, "set_player_current_weapon")
	player_inventory.connect("money_changed", self, "set_money")
	zombie_manager.connect("round_changed", self, "set_round_value")
	set_player_current_weapon()


func set_player_current_weapon(inventory = player_inventory) -> void:
	player_current_weapon = inventory.current_weapon
	set_weapons_gui()
	set_current_ammo_text(player_current_weapon.current_magazine_bullet_count)
	set_total_ammo_text(player_current_weapon.current_max_ammo)
	if not player_current_weapon.is_connected("current_magazine_ammo_changed", self, "set_current_ammo_text"):
		player_current_weapon.connect("current_magazine_ammo_changed", self, "set_current_ammo_text")
	if not player_current_weapon.is_connected("max_ammo_changed", self, "set_total_ammo_text"):
		player_current_weapon.connect("max_ammo_changed", self, "set_total_ammo_text")
	

func set_weapons_gui(inventory = player_inventory) -> void:
	var current_weapon = inventory.current_weapon
	var stored_weapon = inventory.stored_weapon
	
	if current_weapon != null:
		set_weapon1_texture(current_weapon.get_texture())
		
	if stored_weapon != null:
		set_weapon2_texture(stored_weapon.get_texture())


func set_money(new_value: int) -> void:
	money_label.text = str(new_value)


func set_current_ammo_text(new_current_ammo: int) -> void:
	current_ammo_label.text = str(new_current_ammo)
	

func set_total_ammo_text(new_total_ammo: int) -> void:
	total_ammo_label.text = str(new_total_ammo)
	
	
func set_round_value(new_round_value: int) -> void:
	current_round_label.text = str(new_round_value)


func set_weapon1_texture(new_texture: Texture) -> void:
	weapon1.texture = new_texture


func set_weapon2_texture(new_texture: Texture) -> void:
	weapon2.texture = new_texture
