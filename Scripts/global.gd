extends Node

# Game State
var state = 0
enum STATE {
	START_MENU,
	PLAY,
	UPGRADE,
	PAUSE,
	DEAD,
}

# Player
var player : CharacterBody2D 

# Enemy
var enemy_list : Array[RigidBody2D]

# Bullets
var bullet_cont : BulletContainer

# UI
var ui : UI
