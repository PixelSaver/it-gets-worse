extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)

		if get_parent() is Player:
			get_parent().velocity = (global_position - attack.atk_pos) * attack.knockback_str
