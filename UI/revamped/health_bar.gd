extends ProgressBar

@export var label : RichTextLabel


func _on_changed() -> void:
	label.text = "%s/%s" % [value, max_value]


func _on_value_changed(value: float) -> void:
	label.text = "%s/%s" % [value, max_value]
