class_name DeathMenu extends Control

@export var fade_in_duration := 0.3
@export var fade_out_duration := 0.2

@onready var center_cont := $ColorRect/CenterContainer as CenterContainer
@onready var restart_button := center_cont.get_node(^"VBoxContainer/RestartButton") as Button


func _ready() -> void:
	hide()
	#start.grab_focus()



func open() -> void:
	#Global.game_state = Global.Game.DIED
	show()
	restart_button.grab_focus()
	
	#Global.release_mouse()
	get_tree().paused = true

	modulate.a = 0.0
	center_cont.anchor_bottom = 0.5
	var tween := create_tween()
	tween.tween_property(
		self,
		^"modulate:a",
		1.0,
		fade_in_duration
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(
		center_cont,
		^"anchor_bottom",
		1.0,
		fade_out_duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func _on_restart_button_pressed() -> void:
	#Global.reset()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	#close()


func _on_quit_button_pressed() -> void:
	if visible:
		get_tree().quit()
