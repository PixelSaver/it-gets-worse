extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent
@export var invulnerability_timer = 0.0
var invulnerable := false

func damage(attack: Attack):
	#TODO Fix player getting stuck but not getting attacked... refresh areas?
	if invulnerable: return
	
	if health_component:
		health_component.damage(attack)

		if get_parent() is Player:
			get_parent().velocity = (global_position - attack.atk_pos) * attack.knockback_str
			await get_tree().create_timer(.2).timeout
			# get_parent().velocity = (global_position - attack.atk_pos) * attack.knockback_str / 2
		if invulnerability_timer > 0.0:
			invulnerable = true
			await get_tree().create_timer(invulnerability_timer).timeout
			invulnerable = false
func _process(delta: float) -> void:
	if invulnerable:
		print("invulnerable")
