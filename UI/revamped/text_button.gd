class_name TextButton
extends Button

@onready var custom_theme : Theme = preload("res://UI/revamped/custom_theme.tres")

func _init():
	custom_theme.set_type_variation("TextButton","Button")  # tells Godot: use Button theme items
