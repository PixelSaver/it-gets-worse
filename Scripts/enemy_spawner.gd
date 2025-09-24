extends Node2D

@onready var enemy_scene = preload("res://Scenes/enemy.tscn")
var enemy_spawn_rate : float = .3
var enemy_spawn_dist : float = 1000
var time_diff : float = 0

func _process(delta: float) -> void:
	time_diff += delta
	if (time_diff / (enemy_spawn_rate) > 1):
		time_diff -= enemy_spawn_rate
		spawn_enemy()
	
func spawn_enemy():
	if Global.player == null: return
	
	var rand_dir = Vector2.from_angle(randf_range(0, 2 * PI))
	var curr_enemy = enemy_scene.instantiate()
	curr_enemy.global_position = Global.player.global_position + Global.player.velocity + rand_dir * enemy_spawn_dist
	add_child(curr_enemy)
