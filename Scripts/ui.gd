extends CanvasLayer
class_name UI

@onready var hud = $Control/HUD
@onready var hud_text = hud.get_node("$HBoxContainer/Panel/RichTextLabel")
@onready var upgrade_panel = $Control/UpgradePanel
var ui : UI

func _ready():
	await Global.ui
	ui = Global.ui

func _on_health_component_health_changed(new_health: float, max_health:float) -> void:
	hud_text.text = ""
	hud_text.append_text("[color=red][font_size=50]H:" + str(int(new_health)) + "/" + str(int(max_health)))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().paused = !get_tree().paused
