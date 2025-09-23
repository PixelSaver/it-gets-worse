extends Node2D
class_name Gun

@onready var bullet_scene = preload("res://Scenes/bullet.tscn")

func fire(dir:Vector2, speed:float):
	var curr_bullet : Bullet = bullet_scene.instantiate()
	curr_bullet.init(speed, dir, Attack.new(1))
	curr_bullet.global_position = self.global_position
	Global.bullet_cont.add_child(curr_bullet)
	
