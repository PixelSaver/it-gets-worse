extends CanvasLayer
class_name UI

@onready var hud = $Control/HUD as Control
@onready var hud_text = hud.get_node(^"HBoxContainer/Panel/RichTextLabel") as RichTextLabel
@onready var hud_health_bar = hud.get_node(^"HBoxContainer/Panel") as ProgressBar
@onready var upgrade_panel: VBoxContainer = $Control/UpgradePanel
@onready var upgrade_container: HBoxContainer = $Control/UpgradePanel/UpgradeContainer
@onready var ui_upgrade_scene = preload("res://Scenes/ui_upgrade.tscn")

@onready var death_menu = $DeathMenu as DeathMenu
@onready var pause_menu: PauseMenu = $PauseMenu



func _ready():
	Global.ui = self

func _on_health_component_health_changed(new_health: float, max_health:float) -> void:
	if not hud: return
	hud_text.text = ""
	hud_text.append_text("[color=red][font_size=50]H:" + str(int(new_health)) + "/" + str(int(max_health)))
	hud_health_bar.value = new_health
	hud_health_bar.max_value = max_health

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		pause_menu.open()

func show_upgrade(upgrade_res_array:Array[BaseStrategy]):
	upgrade_panel.show()
	upgrade_panel.grab_focus()
	get_tree().paused = true
	
	for child in upgrade_container.get_children():
		child.queue_free()
	
	for i in range(0,upgrade_res_array.size()):
		var curr_upgrade = upgrade_res_array[i] as BaseStrategy
		var curr_upgrade_ui_scene = ui_upgrade_scene.instantiate() as UIUpgrade
		upgrade_container.add_child(curr_upgrade_ui_scene)
		curr_upgrade_ui_scene.stored_upgrade = curr_upgrade
		
		curr_upgrade_ui_scene.connect("pressed", Callable(hide_upgrade))
		
func hide_upgrade():
	upgrade_panel.hide()
	upgrade_panel.release_focus()
	get_tree().paused = false
	
