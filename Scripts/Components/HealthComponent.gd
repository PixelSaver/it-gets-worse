extends Node
class_name HealthComponent

@export var max_health := 4.0
var health : float
signal health_changed(new_health:float)

func _ready() -> void:
	health = max_health
	
func damage(attack: Attack):
	health -= attack.atk_str
	health_changed.emit(health, max_health)
	if health <= 0:
		if get_parent().has_method("kill"):
			get_parent().kill()
		else:
			get_parent().queue_free()

## Takes in a multiplier to affect max health proportionally
func update_max_health(max_multiplier:float):
	max_health *= max_multiplier
	health *= max_multiplier
