extends Node2D

@onready var enemy_scene = preload("res://Scenes/enemy.tscn")
var enemy_spawn_rate : float = 1
var time_diff : float = 0

func _process(delta: float) -> void:
	time_diff += delta
	if (time_diff / (enemy_spawn_rate) > 1):
		time_diff -= enemy_spawn_rate
		spawn_enemy()
	
func spawn_enemy():
	if Global.player == null: return
	
	var curr_enemy = enemy_scene.instantiate()
	add_child(curr_enemy)
