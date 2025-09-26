class_name TweenComponent
extends Node

@onready var control_node : Control = get_parent()
@export var size_mult : float = 1.1
@export var parameter_to_tween : String = "scale"
## From [0,1] offsets, like a texture uv!
@export var custom_pivot : Vector2 = Vector2.ONE / 2

func _ready() -> void:
	get_parent().connect("mouse_entered", _on_node_hovered)
	get_parent().connect("mouse_exited", _on_node_unhovered)
	call_deferred("set_size")

func set_size():
	control_node.pivot_offset = custom_pivot * control_node.size

func _on_node_hovered() -> void:
	tween_node_scale(size_mult)

func _on_node_unhovered() -> void:
	tween_node_scale(1.0)

func tween_node_scale(target: float) -> void:
	if Vector2.ONE * target == control_node.scale: return
	var tween = create_tween()
	tween.tween_property(control_node, parameter_to_tween, Vector2.ONE * target, 0.2).set_trans(Tween.TRANS_SPRING)
