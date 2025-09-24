extends CharacterBody2D
class_name Player

@onready var health_component : HealthComponent = $HealthComponent
@onready var hitbox_component : HitboxComponent = $HitboxComponent
var player_speed = 500
@onready var gun : Gun = $Gun
var player_mag_size
var player_mag_current

func _ready():
	Global.player = self

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		gun.fire(global_position.direction_to(get_global_mouse_position()), 1000)

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * player_speed
	else:
		velocity= Vector2(move_toward(velocity.x, 0, player_speed), move_toward(velocity.y, 0, player_speed))

	move_and_slide()
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
		#
		#if collider is Enemy:
			#collider.apply_central_impulse(-collision.get_normal() * 3)
			#self.damage_player(collider.get_atk())

func kill():
	pass
