extends Node2D
class_name Gun

@onready var bullet_scene = preload("res://Scenes/bullet.tscn")
var cooldown = .1
var timer = 1000000

func _process(delta: float) -> void:
	timer += delta

func fire(dir: Vector2) -> bool:
	if timer < cooldown: return false
	
	var curr_bullet : Bullet = bullet_scene.instantiate()
	curr_bullet.init(dir)
	curr_bullet.bullet_speed = 1000
	curr_bullet.global_position = self.global_position
	Global.bullet_cont.add_child(curr_bullet)
	
	for strategy in Global.player.bullet_upgrades:
		strategy.apply_upgrade(curr_bullet)
	
	timer = 0
	return true
	
