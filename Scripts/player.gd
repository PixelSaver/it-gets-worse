extends CharacterBody2D

var player_speed = 1000
var player

func _ready():
	Global.player = self

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * player_speed
	else:
		velocity= Vector2(move_toward(velocity.x, 0, player_speed), move_toward(velocity.y, 0, player_speed))

	move_and_slide()
