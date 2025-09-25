extends Node
class_name HealthComponent

signal health_changed(new_health:float, max_health:float)

@export var max_health := 4.0 :
	set(value):
		#health_changed.emit(health, max_health)
		max_health = value
var health : float : 
	set(value):
		health_changed.emit(health, max_health)
		health = value

var damage_queue = []
var processing_damage = false

func _ready() -> void:
	health = max_health
	
func damage(attack: Attack):
	damage_queue.append(attack)
	
	if not processing_damage:
		call_deferred("_process_damage_queue")

func _process_damage_queue():
	processing_damage = true
	
	var total_damage = 0
	while damage_queue.size() > 0:
		var curr_attack = damage_queue.pop_front()
		total_damage += curr_attack.atk_str
	
	if total_damage > 0:
		health -= total_damage
	
	if health <= 0:
		if get_parent().has_method("kill"):
			get_parent().kill()
		else:
			get_parent().queue_free()
	
	processing_damage = false
	
	

## Takes in a multiplier to affect max health proportionally
func update_max_health(max_multiplier:float):
	print("max health updated")
	max_health *= max_multiplier
	health *= max_multiplier
