extends Node
class_name HealthComponent

@export var MAX_HEALTH := 10.0
var health : float
signal health_changed(new_health:float)

func _ready() -> void:
	health = MAX_HEALTH
	
func damage(attack: Attack):
	health -= attack.atk_str
	health_changed.emit(health, MAX_HEALTH)
	if health <= 0:
		if get_parent().has_method("kill"):
			get_parent().kill()
		else:
			get_parent().queue_free()
