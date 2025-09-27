extends Node2D
class_name UpgradeManager

var all_upgrades : Array[BaseStrategy] = [
	preload("res://Upgrades/Resources/damage_bullet.tres"),
	preload("res://Upgrades/Resources/health_player.tres"),
	preload("res://Upgrades/Resources/multishot_player.tres"),
	preload("res://Upgrades/Resources/pierce_bullet.tres"),
	preload("res://Upgrades/Resources/ricochet_bullet.tres"),
	preload("res://Upgrades/Resources/size_down_bullet.tres"),
	preload("res://Upgrades/Resources/size_up_bullet.tres"),
	preload("res://Upgrades/Resources/speed_bullet.tres"),
	preload("res://Upgrades/Resources/speed_player.tres"),
]

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
	Global.upgrade_manager = self
	print_debug("UpgradeManager ready, platform: ", OS.get_name())
	
	# For web builds, use preloaded resources
	if OS.get_name() == "Web":
		print_debug("Using preloaded upgrades for web build")
		# all_upgrades is already populated from the preload array above
		print_debug("Preloaded upgrades count: ", all_upgrades.size())
	else:
		# Dynamic loading for non-web build
		var dynamically_loaded = load_all_upgrades_fallback("res://Upgrades/Resources")
		if dynamically_loaded.size() > 0:
			all_upgrades = dynamically_loaded
		
	# Verify upgrades loaded
	#print_debug("Final upgrade count: ", all_upgrades.size())
	#for i in range(all_upgrades.size()):
		#if all_upgrades[i] == null:
			#print_debug("WARNING: Upgrade at index ", i, " is null")
		#else:
			#print_debug("Upgrade ", i, ": ", all_upgrades[i].resource_path if all_upgrades[i].resource_path else "no path")

func load_all_upgrades_fallback(path: String) -> Array[BaseStrategy]:
	var upgrades: Array[BaseStrategy] = []
	
	# Only try dynamic loading if not in web export
	if OS.get_name() != "Web":
		var dir := DirAccess.open(path)
		if dir:
			dir.list_dir_begin()
			var filename = dir.get_next()
			while filename != "":
				if filename.ends_with(".tres"):
					var res = load(path + "/" + filename)
					if res:
						upgrades.append(res)
						print_debug("Loaded upgrade: ", filename)
				filename = dir.get_next()
			print_debug("Total upgrades loaded dynamically: ", upgrades.size())
		else:
			print_debug("Failed to open directory: ", path)
	
	return upgrades


func pick_random(iter:int) -> Array[BaseStrategy]:
	var out :Array[BaseStrategy] = []
	for i in range(iter):
		out.append(
			all_upgrades[randi_range(0,all_upgrades.size()-1)]
		)
	return out


func _on_experience_component_level_up(new_level: int) -> void:
	var upgrade_array : Array[BaseStrategy] = pick_random(3)
	#Global.ui.show_upgrade(test_array)
	Global.in_game_ui.show_upgrade(upgrade_array)
