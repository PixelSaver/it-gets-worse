extends RigidBody2D
class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent
@onready var hitbox_component : HitboxComponent = $HitboxComponent
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var anime: AnimatedSprite2D = $Anime

var enemy_attack : Attack
var enemy_attack_cooldown : float = .5
var attack_timer: Timer
var can_attack: bool = true
var player_in_hitbox: HitboxComponent = null
var exp_value = 1
var enemy_speed : float = 1000
var is_dead : bool = false

func _ready() -> void:
	Global.enemy_list.append(self)
	
	enemy_attack = Attack.new()
	enemy_attack.atk_str = 1
	enemy_attack.knockback_str = 10
	
	attack_timer = Timer.new()
	attack_timer.wait_time = enemy_attack_cooldown
	attack_timer.one_shot = true
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	add_child(attack_timer)
	
	hitbox_component.area_exited.connect(_on_hitbox_component_area_exited)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not Global.player: return
	elif is_dead:
		linear_damp = 10000
	var dir_to_player = self.global_position.direction_to(Global.player.global_position + Global.player.velocity/10)
	dir_to_player = Vector2.from_angle(dir_to_player.angle() + randfn(0,1)).normalized()
	state.apply_force(dir_to_player * enemy_speed)

func get_atk() -> Attack:
	enemy_attack.atk_pos = global_position
	return enemy_attack

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.is_in_group("Player"):
		player_in_hitbox = area
		if can_attack:
			area.damage(get_atk())
			can_attack = false
			attack_timer.start()

func _on_hitbox_component_area_exited(area: Area2D) -> void:
	if area == player_in_hitbox:
		player_in_hitbox = null

func _on_attack_timer_timeout():
	can_attack = true
	if player_in_hitbox and not is_dead:
		player_in_hitbox.damage(get_atk())
		attack_timer.start()
		can_attack = false

func kill():
	if is_dead == true or Global.enemy_list.find(self) == -1: return
	is_dead = true
	call_deferred("disable_collision")
	anime.play("death")
	Global.enemy_list.erase(self)
	Global.enemies_killed += 1
	
	Global.player.experience_component.update_exp(exp_value)
	
	await anime.animation_finished
	queue_free()

func disable_collision():
	collision_shape.disabled = true

func scale_enemy(scale_factor:float):
	hitbox_component.scale = hitbox_component.scale * scale_factor
	health_component.scale = health_component.scale * scale_factor
	collision_shape.scale = collision_shape.scale * scale_factor
	anime.scale = anime.scale * scale_factor
	#anime.speed_scale = anime.speed_scale / ((scale_factor-1)/2+1)
	anime.speed_scale = anime.speed_scale / scale_factor

func randomize_stats():
	scale_enemy(hitbox_component.scale.x * randfn(1,0.05))
	enemy_attack.atk_str *= randfn(1, 0.1)
	attack_timer.wait_time = max(randfn(enemy_attack_cooldown, 0.5), 0.00001)
	enemy_attack_cooldown = attack_timer.wait_time 
	enemy_attack.knockback_str *= randfn(1, 0.1)
	health_component.update_max_health(randfn(1,0.2))
	enemy_speed *= randfn(1, 0.1)
	
