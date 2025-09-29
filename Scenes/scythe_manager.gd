extends Node2D
class_name ScytheManager

const SCYTHE = preload("res://Scenes/scythe.tscn")
var scythe_list : Array[Scythe] = []
var distance : float = 150
var revolve_freq : float = 0.5

func _ready() -> void:
	var player = get_parent() as Player
	update_scythe_list(player.num_scythe)

func update_scythe_list(target_size:int):
	while scythe_list.size() < target_size:
		print("instaitate")
		var scythe = SCYTHE.instantiate()
		#scythe.rotation = randf_range(0,PI*2)
		#scythe.spin_freq *= randfn(1,0.1)
		scythe_list.append(scythe)
		add_child(scythe)
	
	while scythe_list.size() > target_size:
		scythe_list[0].queue_free()
		scythe_list.remove_at(0)
	
	for i in range(scythe_list.size()):
		var scythe = scythe_list[i]
		scythe.revolve_index = float(i) / scythe_list.size()
		scythe.position = rotate_vec(1-scythe.revolve_index) * distance
		scythe.rotation = scythe.global_position.direction_to(get_parent().global_position).angle()

func _process(delta: float) -> void:
	for i in range(scythe_list.size()):
		var scythe = scythe_list[i]
		scythe.revolve_index = fmod(scythe.revolve_index + delta*revolve_freq, 1)
		scythe.position = rotate_vec(1-scythe.revolve_index) * distance

func rotate_vec(index:float) -> Vector2:
	return Vector2.from_angle(2*PI*clampf(index,0,1)).normalized()
