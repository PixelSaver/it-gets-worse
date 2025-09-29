extends Node
class_name HealthComponent

signal health_changed(new_health: float, max_health: float)
signal invulnerability_started()
signal invulnerability_ended()

@export var max_health := 4.0 :
	set(value):
		max_health = value

@export var invulnerability_duration := 0.0  # Duration in seconds

var health: float : 
	set(value):
		health = value

var damage_queue = []
var processing_damage = false
var is_invulnerable = false
var invulnerability_timer: Timer

func _ready() -> void:
	health = max_health
	
	# Create and setup invulnerability timer
	if invulnerability_duration > 0:
		invulnerability_timer = Timer.new()
		invulnerability_timer.wait_time = invulnerability_duration
		invulnerability_timer.one_shot = true
		invulnerability_timer.timeout.connect(_on_invulnerability_timeout)
		add_child(invulnerability_timer)
	
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	health_changed.emit(health, max_health)

func damage(attack: Attack) -> bool:
	if is_invulnerable: return false
		
	damage_queue.append(attack)
	
	if not processing_damage:
		call_deferred("_process_damage_queue")
	return true

func _process_damage_queue():
	processing_damage = true
	
	var total_damage = 0
	var took_damage = false
	
	while damage_queue.size() > 0:
		var curr_attack = damage_queue.pop_front()
		total_damage += curr_attack.atk_str
	
	if total_damage > 0:
		health -= total_damage
		took_damage = true
		
		# Start invulnerability period after taking damage
		start_invulnerability()
	
	if health <= 0:
		if get_parent().has_method("kill"):
			get_parent().kill()
		else:
			get_parent().queue_free()
	
	health_changed.emit(health, max_health)
	processing_damage = false

func start_invulnerability():
	if is_invulnerable or invulnerability_timer == null or invulnerability_duration == 0: return
	
	is_invulnerable = true
	invulnerability_timer.start()
	invulnerability_started.emit()

func _on_invulnerability_timeout():
	is_invulnerable = false
	invulnerability_ended.emit()


func get_is_invulnerable() -> bool:
	if invulnerability_timer == null or invulnerability_duration == 0: return false
	return is_invulnerable

## Takes in a multiplier to affect max health proportionally
func update_max_health(max_multiplier: float):
	health *= max_multiplier
	max_health *= max_multiplier
