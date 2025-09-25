extends RigidBody2D
class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent
@onready var hitbox_component : HitboxComponent = $HitboxComponent
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var anime: AnimatedSprite2D = $Anime
var enemy_speed : float = 1000
var is_dead : bool = false


func _ready() -> void:
	Global.enemy_list.append(self)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not Global.player: return
	elif is_dead:
		linear_damp = 10000
	var dir_to_player = self.global_position.direction_to(Global.player.global_position + Global.player.velocity/10)
	dir_to_player = Vector2.from_angle(dir_to_player.angle() + randfn(0,1)).normalized()
	state.apply_force(dir_to_player * enemy_speed)

func get_atk() -> Attack:
	var attack = Attack.new()
	attack.atk_str = 1
	attack.atk_pos = global_position
	attack.knockback_str = 10
	return attack

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.is_in_group("Player"):
		area.damage(get_atk())

func kill():
	is_dead = true
	call_deferred("disable_collision")
	anime.play("death")
	hitbox_component.is_dead = true
	Global.enemy_list.erase(self)
	await anime.animation_finished
	queue_free()

func disable_collision():
	collision_shape.disabled = true
