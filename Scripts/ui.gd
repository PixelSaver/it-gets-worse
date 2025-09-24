extends CanvasLayer
class_name UI

@onready var hud = $Control/HUD as Control
@onready var hud_text = hud.get_node(^"HBoxContainer/Panel/RichTextLabel") as RichTextLabel
@onready var upgrade_panel = $Control/UpgradePanel
@onready var death_menu = $DeathMenu as DeathMenu
var ui : UI
@onready var pause_menu: PauseMenu = $PauseMenu



func _ready():
	Global.ui = self

func _on_health_component_health_changed(new_health: float, max_health:float) -> void:
	hud_text.text = ""
	hud_text.append_text("[color=red][font_size=50]H:" + str(int(new_health)) + "/" + str(int(max_health)))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		pause_menu.open()
