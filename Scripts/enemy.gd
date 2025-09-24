extends RigidBody2D
class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent
@onready var hitbox_component : HitboxComponent = $HitboxComponent
var enemy_speed : float = 1000


func _ready() -> void:
	Global.enemy_list.append(self)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not Global.player: return
	var dir_to_player = self.global_position.direction_to(Global.player.global_position + Global.player.velocity/10)
	dir_to_player = Vector2.from_angle(dir_to_player.angle() + randfn(0,1)).normalized()
	state.apply_force(dir_to_player * enemy_speed)

func get_atk() -> Attack:
	var attack = Attack.new()
	attack.atk_str = 1
	attack.atk_pos = global_position
	attack.knockback_str = 30
	return attack

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.is_in_group("Player"):
		area.damage(get_atk())
