extends Node

# Game State
var state = 0
enum STATE {
	START_MENU,
	PLAY,
	UPGRADE,
	PAUSE,
	DEAD,
}

# Player
var player : Player 

# Enemy
var enemy_list : Array[RigidBody2D]
func get_closest_enemy(global_position:Vector2)->RigidBody2D:
	var closest_enemy: RigidBody2D = null
	var closest_dist := INF
	
	for enemy in enemy_list:
		if not is_instance_valid(enemy): continue
		
		var dist = global_position.distance_squared_to(
			enemy.global_position
		)
		if dist < closest_dist:
			closest_dist = dist
			closest_enemy = enemy
	
	return closest_enemy
		

# Bullets
var bullet_cont : BulletContainer

# UI
var ui : UI

# Upgrades
var upgrade_manager : UpgradeManager

# Game Timer
var game_timer : GameTimer
