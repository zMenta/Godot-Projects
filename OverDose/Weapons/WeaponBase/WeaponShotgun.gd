extends Weapon


export var pellet_amount: int = 4


func fire() -> void:
	if can_shoot == true and current_magazine_bullet_count > 0:
		GlobalSignals.emit_signal("gun_fired", trauma_amount)
		AudioManager.play(gun_sound)
		can_shoot = false
		spawn_smoke(muzzle.position)
		spawn_bullet_casing(handle.position)
		current_magazine_bullet_count -= 1
		
		
		# Tween
		var tween_up_time := 0.1
		var tween_down_time := 0.15
		var random_recoil_rotation = -rand_range(deg2rad(5), deg2rad(30))
		tween.interpolate_property(weapon_sprite, "rotation", weapon_sprite.rotation, random_recoil_rotation, tween_up_time)
		tween.interpolate_property(weapon_sprite, "rotation", weapon_sprite.rotation, 0, tween_down_time, tween.TRANS_CUBIC, tween.EASE_IN, tween_up_time)
		
		tween.start()
		
		
		for pellets in range(pellet_amount):
			var recoil_radians = deg2rad(rand_range(-current_recoil, current_recoil))
			# Recoil / spread
			var recoil_increment := max_recoil_angle * recoil_climb_weight
			current_recoil = clamp(current_recoil + recoil_increment, min_recoil_angle, max_recoil_angle)
			
			bullet_direction = handle.global_position.direction_to(muzzle.global_position).rotated(recoil_radians)
			GlobalSignals.emit_signal("bullet_fired", Bullet.instance() ,bullet_direction, muzzle.global_position)
	
		
		cooldown_timer.start()
		animation_player.play("MuzzleFlash")
		emit_signal("current_magazine_ammo_changed", current_magazine_bullet_count)
