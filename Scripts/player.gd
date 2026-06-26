class_name Player
extends CharacterBody2D

signal wall_hit

@export var speed = 5

@export var rotation_speed = 400
const angular_speed = PI

var jump_dir : Vector2 

@onready var line: Line2D = $Line2D
@onready var player_sprite: ColorRect = $PlayerSprite
@onready var jump_marker: Marker2D = $JumpDirection
@onready var timer: Timer = $Timer

const GRAVITY = 20.0

# Calculate vector between players current position and mouse cursor
var movement_vector : Vector2

var wall_stick = false

# All possible player colors
# FUTURE: Build state management system
var player_color

enum color {
	RED, #1
	ORANGE, #2
	BLUE, #3
	GREEN #4
}

func _ready():
	# Setting jump timer properties
	# TODO: Convert this timer to make player blow tf up if they spin too long
	timer.wait_time = 5.0
	timer.one_shot = false
	timer.ignore_time_scale = true
	
	timer.start()
	
func _on_timer_timeout() -> void:
	pass

# TODO	Add this for polish
func show_trajectory(delta):
	pass

func _physics_process(delta):
	# Calculating Jump Direction
	jump_dir = jump_marker.position
	
	# Gravity
	if not wall_stick:
		velocity.y += GRAVITY
	else:
		velocity = Vector2.ZERO
	
	if Input.is_action_pressed("left_click"):
		# Marker Rotation around player
		var marker_velocity = Vector2.UP.rotated(rotation) * -speed
		
		jump_marker.rotation += angular_speed * delta
		jump_marker.position += (marker_velocity * 500) * delta 
		
		
		print(jump_marker.rotation)
		look_at(jump_dir)
		
		timer.paused = false
		
		line.show()
		show_trajectory(delta)
		
	if Input.is_action_just_released("left_click"):
		timer.paused = true
		wall_stick = false
		
		line.hide()
		
		jump()
		velocity.y += GRAVITY
	
	if movement_vector.length() > 0:
		movement_vector = movement_vector.normalized()
	
	# Automatically multiplies by DeltaTime
	move_and_slide()
	
func jump():
	# FIXME: Check if the player is cllided w/ something before adding the vector! Otherwise they will clip through wall
	movement_vector = jump_marker.position - position
	var jump_vel = speed * movement_vector / 3
	velocity += jump_vel
	
	
	print(jump_vel)
	
	if not is_on_wall():
		$Area2D/CollisionShape2D.disabled = false

	
func _on_area_2d_body_entered(body: Node2D) -> void:
	wall_hit.emit()

func _on_wall_hit() -> void:
	wall_stick = true
	jump_marker.position = Vector2(0, 0)
	jump_marker.rotation = 0
	
	if not Input.is_action_pressed("left_click"):
		rotation = 0
		#FIXME: Player not landing flush on surfaces (Area2d collider is too big)
	
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
