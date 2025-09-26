extends Node2D
class_name ExperienceComponent

signal exp_changed(new_exp:float, new_max_exp:float)
signal level_up(new_level:int)
@export var leveling_curve : Curve
var level :int = 1
var experience : float = 0.0 :
	set(val):
		experience = val
var max_exp : float = 100 :
	set(val):
		max_exp = val

func _ready():
	max_exp = calc_max_exp(1)

func update_exp(additional_exp:float):
	experience += additional_exp
	while experience > max_exp:
		experience -= max_exp
		max_exp = calc_max_exp(level + 1)
		level += 1
		level_up.emit(level)
	exp_changed.emit(experience, max_exp)

func calc_max_exp(new_level:int):
	return 40 * exp(-float(new_level) / 50) + 1
