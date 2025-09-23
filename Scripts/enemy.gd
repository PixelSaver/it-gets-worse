extends RigidBody2D
class_name Enemy

func _ready() -> void:
	Global.enemy_list.append(self)
