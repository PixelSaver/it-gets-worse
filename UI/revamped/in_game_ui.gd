extends Control
class_name InGameUI

@export var hud : Control
@export var hud_health_bar : ProgressBar 
@export var hud_exp_bar : ProgressBar
@export var upgrade_screen : Control
@export var pause_screen : Control
@export var menu_screen : Control

func update_exp_bar(new_value:float, new_max_value:float):
	hud_exp_bar.max_value = new_max_value
	hud_exp_bar.value = new_value
func update_health_bar(new_value:float, new_max_value:float):
	hud_health_bar.max_value = new_max_value
	hud_health_bar.value = new_value

# Pause Buttons
func _on_pause_resume_pressed() -> void:
	pass # Replace with function body.
func _on_pause_options_pressed() -> void:
	option_show()
func _on_pause_controls_pressed() -> void:
	pass # Replace with function body.
func _on_pause_quit_pressed() -> void:
	get_tree().quit()
func pause_show():
	pass

# Menu Buttons
func _on_menu_continue_pressed() -> void:
	pass # Replace with function body.
func _on_menu_options_pressed() -> void:
	option_show()
func _on_menu_controls_pressed() -> void:
	pass # Replace with function body.
func _on_menu_quit_pressed() -> void:
	get_tree().quit()
func menu_show():
	pass

# Option Buttons
func option_show():
	pass
