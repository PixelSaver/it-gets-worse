extends Node2D
class_name Gun

@onready var bullet_scene = preload("res://Scenes/bullet.tscn")
var spread : float = .5
var recoil_str : float = 300
var multishot : int = 1
var bullets_per_second = 5
var timer = 1000000

func _process(delta: float) -> void:
	timer += delta

func fire(dir: Vector2) -> bool:
	if timer < 1/float(bullets_per_second): return false
	timer = 0
	
	# normalize the base direction
	dir = dir.normalized()
	var base_angle = dir.angle()
	
	if multishot <= 1:
		var rand_angle = (dir + Vector2.from_angle(randfn(dir.angle(), spread))).angle()
		_spawn_bullet(rand_angle)
	else:
		# total spread (in radians)
		var total_spread = spread
		var step = total_spread / float(multishot - 1)
		
		for i in range(multishot):
			# offset angles symmetrical across spread
			var offset = (i - (multishot - 1) / 2.0) * step
			_spawn_bullet(base_angle + offset)
	
	# apply recoil (use original dir, not offset one)
	var player = get_parent() as Player
	player.add_impulse(-dir * recoil_str)
	
	return true

func _spawn_bullet(angle: float) -> void:
	var curr_bullet : Bullet = bullet_scene.instantiate()
	var direction = Vector2.from_angle(angle).normalized()
	
	
	curr_bullet.init(direction)
	curr_bullet.bullet_speed = 1000
	curr_bullet.bullet_lifetime = 3
	curr_bullet.global_position = global_position
	Global.bullet_cont.add_child(curr_bullet)
	
	# apply upgrades
	for strategy in Global.player.bullet_upgrades:
		strategy.apply_upgrade(curr_bullet)
