extends Node2D
class_name ExperienceComponent

signal exp_changed(new_exp:float, new_max_exp:float)
@export var leveling_curve : Curve
var level :int = 1
var exp : float = 0.0 :
	set(val):
		exp = val
var max_exp : float = 100 :
	set(val):
		max_exp = val

func _ready():
	max_exp = calc_max_exp(1)

func update_exp(additional_exp:float):
	exp += additional_exp
	if exp > max_exp:
		exp -= max_exp
		max_exp = calc_max_exp(level + 1)
		level += 1
	exp_changed.emit(exp, max_exp)

func calc_max_exp(new_level:int):
	return 40 * exp(-new_level / 50) + 1
