extends Area2D
class_name Bullet

var bullet_speed 
var velocity
var stored_attack : Attack
var bullet_lifetime : float
var bullet_health 

func init(speed:float, dir:Vector2, attack:Attack, lifetime:float=10, health:int=1):
	bullet_speed = speed
	velocity = dir
	stored_attack = attack
	bullet_lifetime = lifetime
	bullet_health = health

func _physics_process(delta: float) -> void:
	self.translate(velocity * delta * bullet_speed)

func _process(delta: float) -> void:
	bullet_lifetime -= delta
	if bullet_lifetime <= 0:
		self.queue_free()


func _on_body_entered(body: Node2D) -> void:
	var hit = false
	#if body is Player:
		#body = body as Player
		#body.damage_player(stored_attack)
		#bullet_health -= 1
	#elif body is Enemy:
	if body is Enemy:
		body = body as Enemy
		body.damage_enemy(stored_attack)
		bullet_health -= 1
		
	if bullet_health <= 0:
		queue_free()
