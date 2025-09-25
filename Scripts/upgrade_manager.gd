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
