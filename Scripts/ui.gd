extends CanvasLayer
class_name UI

@onready var hud_text = $Control/HUD/HBoxContainer/Panel/RichTextLabel

func _on_health_component_health_changed(new_health: float, max_health:float) -> void:
	hud_text.text = ""
	hud_text.append_text("[color=red][font_size=50]H:" + str(new_health) + "/" + str(max_health))
