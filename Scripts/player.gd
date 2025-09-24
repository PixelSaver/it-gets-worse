extends CharacterBody2D
class_name Player

# Components
@onready var health_component : HealthComponent = $HealthComponent
@onready var hitbox_component : HitboxComponent = $HitboxComponent
var player_speed = 300
var acceleration = 5000
var friction : float = 400
var force := Vector2.ZERO  # Accumulated forces
# Gun stuff
@onready var gun : Gun = $Gun
var player_mag_size
var player_mag_current
var gun_automatic : bool = true
var bullet_upgrades : Array[BaseBulletStrategy] = []


# Called by other nodes to add a force
func apply_force(f: Vector2) -> void:
	force += f
	
func _ready():
	Global.player = self

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left_click") and gun_automatic:
		gun.fire(
			global_position.direction_to(
				get_global_mouse_position()
			)
		)
	elif Input.is_action_just_pressed("left_click"):
		gun.fire(
			global_position.direction_to(
				get_global_mouse_position()
			)
		)
	
	
	var direction := Input.get_vector("left", "right", "up", "down")
	# Apply input as acceleration
	var target_velocity = direction.normalized() * player_speed
	velocity += get_impulse(velocity, target_velocity,acceleration, delta)
	#velocity *= axis_multiplier_resource.value
	move_and_slide()
	#velocity *= axis_compensation
	
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
		#
		#if collider is Enemy:
			#collider.apply_central_impulse(-collision.get_normal() * 3)
			#self.damage_player(collider.get_atk())

# Impulse functions from https://github.com/nezvers/Godot-GameTemplate/
## Adds an impulse to velocity, like a kickback
func add_impulse(impulse:Vector2)->void:
	velocity += impulse

## Calculate impulse Vector2 for delta time amount
func get_impulse(current_velocity:Vector2, target_velocity:Vector2, acceleration:float, delta:float)->Vector2:
	var _direction:Vector2 = target_velocity - current_velocity 
	var _distance:float = _direction.length()
	acceleration = delta * acceleration
	var _ratio:float = 0
	if _distance > 0.0:
		_ratio = min(acceleration / _distance, 1.0)
	return (_direction * _ratio)
	
func kill():
	Global.ui.death_menu.open()
