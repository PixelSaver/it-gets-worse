extends Node
class_name Attack

var atk_str : float = 1
var knockback_dir : Vector2 = Vector2.ZERO
var knockback_str : float = 0

func _init(str:float, k_dir: Vector2 = Vector2.ZERO, k_str:float = 0) -> void:
	atk_str = str
	knockback_dir = k_dir
	knockback_str = k_str
