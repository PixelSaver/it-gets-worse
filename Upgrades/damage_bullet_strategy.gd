class_name DamageBulletStrategy
extends BaseBulletStrategy

func apply_upgrade(bullet: Bullet):
	bullet.stored_attack.atk_str += 5.0
