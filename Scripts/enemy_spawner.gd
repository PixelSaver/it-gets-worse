extends Node2D

@onready var enemy_scene = preload("res://Scenes/enemy.tscn")

func _process(delta: float) -> void:
	var curr_enemy = enemy_scene.instantiate()
	add_child(curr_enemy)
	
