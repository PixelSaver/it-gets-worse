# Run this in Godot Editor > Script > New Script > Tool Script
# Then press "Run" to get a list of all your upgrade files
@tool
extends EditorScript

var directory = "res://Upgrades/Resources/Negative"

func _run():
	print("=== UPGRADE FILES IN %d ===" % directory)
	var dir = DirAccess.open(directory)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var count = 0
		
		while file_name != "":
			if file_name.ends_with(".tres"):
				print('preload("res://Upgrades/Resources/' + file_name + '"),')
				count += 1
			file_name = dir.get_next()
			
		print("=== FOUND ", count, " UPGRADE FILES ===")
		print("Copy the preload lines above into your UpgradeManager all_upgrades array")
	else:
		print("Could not open res://Upgrades/Resources/ directory")
