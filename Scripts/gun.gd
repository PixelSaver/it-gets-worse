extends Node2D
class_name Gun

@onready var bullet_scene = preload("res://Scenes/bullet.tscn")
var spread : float = .3
var recoil_str : float = 100
var multishot
var cooldown = .1
var timer = 1000000

func _process(delta: float) -> void:
	timer += delta

func fire(dir: Vector2) -> bool:
	if timer < cooldown: return false
	
	var curr_bullet : Bullet = bullet_scene.instantiate()
	dir = (dir + Vector2.from_angle(randfn(dir.angle(), spread))).normalized()
	curr_bullet.init(dir)
	curr_bullet.bullet_speed = 1000
	curr_bullet.global_position = self.global_position
	Global.bullet_cont.add_child(curr_bullet)
	
	get_parent().add_impulse((dir - global_position).normalized() * recoil_str )
	
	for strategy in Global.player.bullet_upgrades:
		strategy.apply_upgrade(curr_bullet)
	
	timer = 0
	return true
	
