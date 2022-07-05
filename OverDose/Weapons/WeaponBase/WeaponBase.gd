extends Node2D
class_name Weapon


signal current_magazine_ammo_changed(current_magazine_bullet_count)
signal max_ammo_changed(current_max_ammo)


onready var muzzle := $Muzzle
onready var handle := $Handle
onready var cooldown_timer := $FireCooldownTimer
onready var reload_timer := $ReloadTimer
onready var animation_player := $AnimationPlayer
onready var tween := $Tween
onready var weapon_sprite := $WeaponSprite


export var gun_sound = "res://Weapons/WeaponBase/GunSound1.wav"
export(PackedScene) var Bullet : PackedScene
export(PackedScene) var bullet_casing_particle : PackedScene
export(PackedScene) var smoke_particle : PackedScene
export var max_recoil_angle := 5.0 # Both Axis. 5 + 5 degrees = 10 degress total
export var min_recoil_angle := 2.0
export (float, 1) var recoil_climb_weight := 0.1
export (float, 1) var recoil_recovery_weight := 0.05
export var magazine_size := 10
export var max_ammo := 100
export var trauma_amount := 0.1


onready var current_magazine_bullet_count = magazine_size
onready var current_max_ammo = max_ammo
var current_recoil := min_recoil_angle
var bullet_direction := Vector2.ZERO
var can_shoot := true
var is_reloading := false


func _physics_process(delta: float) -> void:
	if not Input.is_action_pressed("shoot"):
		var recoil_decrement := max_recoil_angle * recoil_recovery_weight
		current_recoil = clamp(current_recoil - recoil_decrement, min_recoil_angle, max_recoil_angle)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and current_magazine_bullet_count == 0:
		AudioManager.play("res://Weapons/WeaponBase/click.wav")


func reload() -> void:
	if current_magazine_bullet_count == magazine_size:
		return
	
	if cooldown_timer.is_stopped() and reload_timer.is_stopped() and current_max_ammo > 0 and not Input.is_action_pressed("shoot"):
		is_reloading = true
		can_shoot = false
		animation_player.play("Reload")
		reload_timer.start()


func fire() -> void:
	if can_shoot == true and current_magazine_bullet_count > 0:
		GlobalSignals.emit_signal("gun_fired", trauma_amount)
		AudioManager.play(gun_sound)
		can_shoot = false
		spawn_smoke(muzzle.position)
		spawn_bullet_casing(handle.position)
		current_magazine_bullet_count -= 1
		var recoil_radians = deg2rad(rand_range(-current_recoil, current_recoil))
		bullet_direction = handle.global_position.direction_to(muzzle.global_position).rotated(recoil_radians)
		
		# Recoil / spread
		var recoil_increment := max_recoil_angle * recoil_climb_weight
		current_recoil = clamp(current_recoil + recoil_increment, min_recoil_angle, max_recoil_angle)
		
		
		# Tween
		var tween_up_time := 0.1
		var tween_down_time := 0.15
		var random_recoil_rotation = -rand_range(deg2rad(5), deg2rad(30))
		tween.interpolate_property(weapon_sprite, "rotation", weapon_sprite.rotation, random_recoil_rotation, tween_up_time)
		tween.interpolate_property(weapon_sprite, "rotation", weapon_sprite.rotation, 0, tween_down_time, tween.TRANS_CUBIC, tween.EASE_IN, tween_up_time)
		
		tween.start()
		
		cooldown_timer.start()
		animation_player.play("MuzzleFlash")
		GlobalSignals.emit_signal("bullet_fired", Bullet.instance() ,bullet_direction, muzzle.global_position)
		emit_signal("current_magazine_ammo_changed", current_magazine_bullet_count)


func spawn_bullet_casing(casing_position: Vector2) -> void:
	var bullet_casing = bullet_casing_particle.instance()
	bullet_casing.global_position = casing_position
	get_parent().add_child(bullet_casing)
	
	
func spawn_smoke(smoke_position: Vector2) -> void:
	var smoke = smoke_particle.instance()
	smoke.global_position = smoke_position
	get_parent().add_child(smoke)


func get_texture() -> Texture:
	return weapon_sprite.texture


func _on_ReloadTimer_timeout() -> void:
	animation_player.play("Rotation_0")
	is_reloading = false
	
	var ammo_amount = magazine_size - current_magazine_bullet_count
	if ammo_amount > current_max_ammo:
		var ammo_difference = ammo_amount - current_max_ammo
		ammo_amount -= ammo_difference
	current_magazine_bullet_count += ammo_amount
	current_max_ammo -= ammo_amount
	
	can_shoot = true
	current_max_ammo = clamp(current_max_ammo, 0, max_ammo)
	emit_signal("current_magazine_ammo_changed", current_magazine_bullet_count)
	emit_signal("max_ammo_changed", current_max_ammo)


func _on_FireCooldownTimer_timeout() -> void:
	can_shoot = true
