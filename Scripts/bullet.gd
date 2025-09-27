extends Area2D
class_name Bullet

var bullet_speed : float
var bullet_direction : Vector2 :
	set(dir):
		bullet_direction = dir.normalized()
		self.rotation = dir.angle()
var stored_attack : Attack
var bullet_lifetime : float
var bullet_pierce : int 
var bullet_ricochet : int

var hit_enemies = []  

func init(dir:Vector2, lifetime:float=10):
	bullet_direction = dir
	bullet_lifetime = lifetime
	
	stored_attack = Attack.new()
	stored_attack.atk_str = 1
	stored_attack.knockback_str = 100
	bullet_pierce = 1
	bullet_ricochet = 1

func _physics_process(delta: float) -> void:
	self.translate(bullet_direction * delta * bullet_speed)

func _process(delta: float) -> void:
	bullet_lifetime -= delta
	if bullet_lifetime <= 0:
		self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var health = area as HitboxComponent
		if health in hit_enemies: return  # This bullet already hit this enemy
		
		hit_enemies.append(health)
		call_deferred("_apply_damage", health)
		bullet_pierce -= 1
		if bullet_pierce <= 0:
			if bullet_ricochet > 0:
				bullet_ricochet -= 1
				var closest_enemy = Global.get_closest_enemy(self.global_position)
				bullet_direction = closest_enemy.global_position + closest_enemy.linear_velocity - global_position
			else: 
				queue_free()
func _apply_damage(health: HitboxComponent):
	health.damage(stored_attack)
