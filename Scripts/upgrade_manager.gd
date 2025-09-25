extends Node2D
class_name UpgradeManager

var all_upgrades : Array[BaseStrategy] = []

func load_all_upgrades(path: String) -> Array[BaseStrategy]:
	var upgrades: Array[BaseStrategy] = []
	var dir := DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var filename = dir.get_next()
		while filename != "":
			if filename.ends_with(".tres"):
				var res = load(path + "/" + filename)
				if res:
					upgrades.append(res)
			filename = dir.get_next()
	return upgrades

func _ready():
	all_upgrades = load_all_upgrades("res://Upgrades/Resources")
	Global.upgrade_manager = self

func pick_random(iter:int) -> Array[BaseStrategy]:
	var out :Array[BaseStrategy] = []
	for i in range(iter):
		out.append(
			all_upgrades[randi_range(0,all_upgrades.size()-1)]
		)
	return out


func _on_experience_component_level_up(new_level: int) -> void:
	var test_array : Array[BaseStrategy] = pick_random(3)
	Global.ui.show_upgrade(test_array)
