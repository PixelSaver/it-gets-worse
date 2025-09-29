extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(attack: Attack):
	#TODO Fix player getting stuck but not getting attacked... refresh areas?
	
	if health_component:
		if health_component.damage(attack) == false: return
		
		if get_parent() is Player:
			get_parent().velocity = (global_position - attack.atk_pos).normalized() * attack.knockback_str
		elif get_parent() is Enemy:
			var par = get_parent() as Enemy
			par.apply_central_impulse(attack.bullet_dir * attack.knockback_str)
			par.apply_central_impulse(
				(global_position - attack.atk_pos).normalized() * attack.knockback_str
			)
			await create_tween().tween_property(par.anime, "modulate", Color(Color.WHITE, 0.4), 0.2).finished
			create_tween().tween_property(par.anime, "modulate", Color(Color.WHITE, 1), 0.2)
		#await get_tree().create_timer(invulnerability_timer).timeout

		
