extends BaseEnemyStrategy
class_name HealthEnemyStrategy

@export var health_mult : float = 1.2

func apply_upgrade(enemy: Enemy):
	enemy.health_component.update_max_health(health_mult)
	enemy.apply_scale(Vector2.ONE * 1.4)
