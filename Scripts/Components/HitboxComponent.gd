extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(attack: Attack):
	#TODO Fix player getting stuck but not getting attacked... refresh areas?
	
	if health_component:
		if health_component.damage(attack) == false: return
		
		if get_parent() is Player:
			get_parent().velocity = (global_position - attack.atk_pos) * attack.knockback_str
		#await get_tree().create_timer(invulnerability_timer).timeout

		
