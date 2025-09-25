@tool
extends EditorScript

const OUTPUT_EXTENSION = ".tres"

var strategy_files = []

func _run():
	print("=== Resource Generator Started ===")
	_scan_for_strategy_files()
	_generate_all_resources()
	print("=== Resource Generator Finished ===")

func _scan_for_strategy_files():
	strategy_files.clear()
	_scan_directory("res://Upgrades")
	print("Found ", strategy_files.size(), " strategy files")

func _scan_directory(path: String):
	var dir = DirAccess.open(path)
	if dir == null:
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		var full_path = path + "/" + file_name
		
		if file_name.get_extension() == "gd" and file_name.contains("strategy"):
			strategy_files.append(full_path)
			print("Found strategy file: ", full_path)
		
		file_name = dir.get_next()

func _generate_all_resources():
	var generated_count = 0
	
	for script_path in strategy_files:
		var output_path = _get_resource_output_path(script_path)
		
		if _generate_resource_file(script_path, output_path):
			generated_count += 1
	
	print("Generated ", generated_count, " resource files")
	EditorInterface.get_resource_filesystem().scan()

func _get_resource_output_path(script_path: String) -> String:
	var filename = script_path.get_file().get_basename()
	var clean_name = _clean_strategy_name(filename)
	
	# Change this path to wherever you want the resources
	var output_dir = "res://Upgrades/Resources"  # Or "res://Resources" or any path you want
	
	return output_dir + "/" + clean_name.to_snake_case() + OUTPUT_EXTENSION

func _clean_strategy_name(name: String) -> String:
	# Remove "Strategy" suffix if present
	if name.ends_with("Strategy"):
		name = name.substr(0, name.length() - 8)
	
	# Remove "strategy" from anywhere in the name (case insensitive)
	name = name.replacen("strategy", "")
	
	# Clean up any double underscores or leading/trailing underscores
	while name.contains("__"):
		name = name.replace("__", "_")
	
	while name.begins_with("_"):
		name = name.substr(1)
	while name.ends_with("_"):
		name = name.substr(0, name.length() - 1)
	
	if name == "":
		name = "resource"
	
	return name

func _generate_resource_file(script_path: String, output_path: String) -> bool:
	if FileAccess.file_exists(output_path):
		print("Resource file already exists: ", output_path)
		return false
	
	var script = load(script_path)
	if script == null:
		print("Failed to load script: ", script_path)
		return false
	
	var resource_instance = script.new()
	if not resource_instance is Resource:
		print("Script is not a Resource: ", script_path)
		return false
	
	var result = ResourceSaver.save(resource_instance, output_path)
	if result == OK:
		print("Generated resource: ", output_path)
		return true
	else:
		print("Failed to save resource: ", output_path, " Error: ", result)
		return false
