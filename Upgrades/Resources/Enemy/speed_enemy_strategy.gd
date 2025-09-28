extends BaseEnemyStrategy
class_name SpeedEnemyStrategy

@export var speed_mult : float = 1.2

func apply_upgrade(enemy: Enemy):
	enemy.enemy_speed *= speed_mult
	enemy.apply_scale(Vector2.ONE * .9)
