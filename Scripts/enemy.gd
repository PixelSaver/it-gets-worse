extends RigidBody2D
class_name Enemy


var enemy_speed : float = 1000
var enemy_health = 10

func _ready() -> void:
	Global.enemy_list.append(self)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not Global.player: return
	var dir_to_player = self.global_position.direction_to(Global.player.global_position + Global.player.velocity/10)
	state.apply_force(dir_to_player * enemy_speed)

func get_atk() -> Attack:
	return Attack.new(1, self.global_position.direction_to(Global.player.global_position), 5)

func damage_enemy(atk : Attack):
	enemy_health -= atk.atk_str
	if enemy_health <= 0:
		queue_free()
		return
	
	self.apply_central_impulse(atk.knockback_dir * atk.knockback_str * 100)
