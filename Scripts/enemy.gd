extends RigidBody2D
class_name Enemy

var enemy_speed : float = 1

func _ready() -> void:
	Global.enemy_list.append(self)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	if Global.player:
		var dir_to_player = self.global_position.direction_to(Global.player.global_position+Global.player.velocity)
		state.apply_force(dir_to_player*enemy_speed)
