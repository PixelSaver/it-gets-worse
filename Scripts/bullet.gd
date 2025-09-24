extends Area2D
class_name Bullet

var bullet_speed : float
var velocity : Vector2
var stored_attack : Attack
var bullet_lifetime : float
var bullet_pierce : int 

func init(dir:Vector2, lifetime:float=10):
	velocity = dir
	self.rotation = dir.angle()
	bullet_lifetime = lifetime
	
	stored_attack = Attack.new()
	stored_attack.atk_str = 1
	bullet_pierce = 1

func _physics_process(delta: float) -> void:
	self.translate(velocity * delta * bullet_speed)

func _process(delta: float) -> void:
	bullet_lifetime -= delta
	if bullet_lifetime <= 0:
		self.queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var health = area as HitboxComponent
		health.damage(stored_attack)
		queue_free()
