extends Node2D
class_name Scythe

@onready var area: Area2D = $HitScan
@onready var collision: CollisionPolygon2D = $HitScan/CollisionPolygon2D
@onready var sprite: Sprite2D = $Sprite2D
var spin_freq : float = -8
var hit_enemies : Dictionary[HitboxComponent, float] = {}
var revolve_index : float = 0
var stored_attack : Attack
var damage_cooldown := 0.5 

func _ready() -> void:
	stored_attack = Attack.new()
	
	stored_attack = Attack.new()
	stored_attack.atk_str = 1
	stored_attack.knockback_str = 300

func _process(delta: float) -> void:
	rotation += spin_freq * delta

	for enemy in hit_enemies.keys():
		if not enemy: continue
		hit_enemies[enemy] -= delta
		if hit_enemies[enemy] <= 0.0:
			_apply_damage(enemy)
			hit_enemies[enemy] = damage_cooldown

func _on_hit_scan_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		if area.is_in_group("Player"): return
		var hitbox = area as HitboxComponent
		if not hit_enemies.has(hitbox):
			hit_enemies[hitbox] = 0.0 # ready to take damage
			_apply_damage(area)

func _on_hit_scan_area_exited(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox = area as HitboxComponent
		hit_enemies.erase(area)

func _apply_damage(health: HitboxComponent):
	stored_attack.atk_pos = get_parent().global_position
	health.damage(stored_attack)
	
