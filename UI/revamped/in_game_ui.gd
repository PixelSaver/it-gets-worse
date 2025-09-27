extends Control
class_name InGameUI

@export var hud : Control
@export var hud_health_bar : ProgressBar 
@export var hud_exp_bar : ProgressBar
@export var hud_score : RichTextLabel
@export var upgrade_screen : Control
@export var upgrade_container : Control
@export var pause_screen : Control
@export var death_screen : Control
@export var death_score : RichTextLabel
@export var death_enemies : RichTextLabel 

var single_upgrade_ui_scene : PackedScene 

func _ready():
	Global.in_game_ui = self
	
	single_upgrade_ui_scene = load("res://UI/revamped/single_upgrade_ui.tscn")
	print_debug("Scene loaded successfully: ", single_upgrade_ui_scene != null)
	
	for child in upgrade_container.get_children():
		child.connect("pressed", Callable(upgrade_hide))
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		pause_toggle()

func update_exp_bar(new_value:float, new_max_value:float):
	if new_value > hud_exp_bar.value and hud_exp_bar.max_value == new_max_value:
		var tween = create_tween()
		tween.tween_property(hud_exp_bar, "value", new_value, .3)
		tween.set_trans(Tween.TRANS_QUINT)
	else:
		hud_exp_bar.max_value = new_max_value
		hud_exp_bar.value = new_value
func update_health_bar(new_value:float, new_max_value:float):
	if hud_health_bar.max_value == new_max_value:
		var tween = create_tween()
		tween.tween_property(hud_health_bar, "value", new_value, .3)
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
	#option_show()
	pass
func _on_pause_controls_pressed() -> void:
	pass # Replace with function body.
func _on_pause_quit_pressed() -> void:
	get_tree().quit()
func pause_toggle():
	if pause_screen.visible:
		pause_screen.hide()
		pause_screen.release_focus()
		get_tree().paused = false
	else:
		pause_screen.show()
		pause_screen.grab_focus()
		get_tree().paused = true


# Death Buttons
func _on_death_restart_pressed() -> void:
	var main_scene = load("res://Scenes/main.tscn")
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_scene)
func _on_death_quit_pressed() -> void:
	get_tree().quit()


func death_show():
	death_score.text = "Score: %s" % str(snappedf(Global.game_timer.total_time,0.001))
	death_enemies.text = "Enemies Killed: %s" % str(Global.enemies_killed)
	death_screen.show()
	death_screen.grab_focus()
	get_tree().paused = true
	

func show_upgrade(arr:Array[BaseStrategy]):
	upgrade_screen.show()
	upgrade_screen.grab_focus()
	get_tree().paused = true
	
	var children = upgrade_container.get_children()
	var rand_upgrades = Global.upgrade_manager.pick_random(children.size())
	for i in range(children.size()):
		var ui_upgrade = children[i] as SingleUIUpgrade
		ui_upgrade.stored_upgrade = rand_upgrades[i]
	

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
