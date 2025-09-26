extends Control
class_name InGameUI

@export var hud : Control
@export var hud_health_bar : ProgressBar 
@export var hud_exp_bar : ProgressBar
@export var hud_score : RichTextLabel
@export var upgrade_screen : Control
@export var upgrade_container : Control
@export var pause_screen : Control

@onready var single_upgrade_ui_scene : PackedScene = preload("res://UI/revamped/single_upgrade_ui.tscn")

func _ready():
	Global.in_game_ui = self

func update_exp_bar(new_value:float, new_max_value:float):
	if new_value > hud_exp_bar.value and hud_exp_bar.max_value == new_max_value:
		var tween = create_tween()
		tween.tween_property(hud_exp_bar, "value", new_value, 1)
		tween.set_trans(Tween.TRANS_QUINT)
	else:
		hud_exp_bar.max_value = new_max_value
		hud_exp_bar.value = new_value
func update_health_bar(new_value:float, new_max_value:float):
	if hud_health_bar.max_value == new_max_value:
		var tween = create_tween()
		tween.tween_property(hud_health_bar, "value", new_value, 1)
		tween.set_trans(Tween.TRANS_QUINT)
	else:
		hud_health_bar.max_value = new_max_value
		hud_health_bar.value = new_value
func update_score(new_score:float):
	hud_score.text = "Score: " + str(snapped(new_score,0.1))

# Pause Buttons
signal pause_resume_pressed
func _on_pause_resume_pressed() -> void:
	pause_resume_pressed.emit()
func _on_pause_options_pressed() -> void:
	option_show()
func _on_pause_controls_pressed() -> void:
	pass # Replace with function body.
func _on_pause_quit_pressed() -> void:
	get_tree().quit()
func pause_show():
	pass


# Option Buttons
func option_show():
	pass

func death_show():
	pass

func show_upgrade(arr:Array[BaseStrategy]):
	upgrade_screen.show()
	upgrade_screen.grab_focus()
	get_tree().paused = true
	
	for child in upgrade_container.get_children():
		child.queue_free()
	
	for i in range(0,arr.size()):
		var curr_upgrade = arr[i] as BaseStrategy
		var curr_upgrade_ui_scene = single_upgrade_ui_scene.instantiate() as SingleUIUpgrade
		upgrade_container.add_child(curr_upgrade_ui_scene)
		curr_upgrade_ui_scene.stored_upgrade = curr_upgrade
		
		curr_upgrade_ui_scene.connect("pressed", Callable(upgrade_hide))

func upgrade_hide():
	upgrade_screen.hide()
	upgrade_screen.release_focus()
	get_tree().paused = false
	

func _on_game_timer_timer_update(new_timer_value: float) -> void:
	update_score(new_timer_value)


func _on_health_component_health_changed(new_health: float, max_health: float) -> void:
	update_health_bar(new_health, max_health)


func _on_experience_component_exp_changed(new_exp: float, new_max_exp: float) -> void:
	update_exp_bar(new_exp, new_max_exp)
