extends Node2D

@onready var enemy_scene = preload("res://Scenes/enemy.tscn")
var enemy_spawn_rate : float = .3
var spawn_rate_mult : float = 1
var enemy_spawn_dist : float = 1000
var time_diff : float = 0

func _process(delta: float) -> void:
	time_diff += delta
	if (time_diff / (enemy_spawn_rate * spawn_rate_mult) > 1):
		time_diff -= enemy_spawn_rate * spawn_rate_mult
		spawn_enemy()
	
func spawn_enemy():
	if Global.player == null or Global.enemy_list.size() > 1000: return
	
	var rand_dir = Vector2.from_angle(randf_range(0, 2 * PI))
	var curr_enemy = enemy_scene.instantiate()
	curr_enemy.global_position = Global.player.global_position + Global.player.velocity + rand_dir * enemy_spawn_dist
	add_child(curr_enemy)
	await get_tree().process_frame
	add_enemy_upgrades(curr_enemy)

func add_enemy_upgrades(enemy:Enemy):
	var upgrade_count = floor(Global.game_timer.total_time / 10)+1
	var upgrade_arr := Global.upgrade_manager.pick_random_enemy_upgrade(upgrade_count)
	for upgrade in upgrade_arr:
		upgrade.apply_upgrade(enemy)
	
	enemy.randomize_stats()

func _on_experience_component_level_up(new_level: int) -> void:
	spawn_rate_mult = exp(-float(new_level)/10)
