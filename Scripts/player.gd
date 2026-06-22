class_name Player
extends CharacterBody2D

@onready var speed = 100
@onready var line: Line2D = $Line2D
@onready var player: Player = $"."

@onready var timer: Timer = $Timer
var timer_seconds : float

# Calculate vector between players current position and mouse cursor
var player_pos : Vector2
var mouse_pos : Vector2 
var movement_vector : Vector2

var screen_size
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var max_points = 250


func _ready():
	screen_size = get_viewport_rect().size
	
	# Setting jump timer properties
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.ignore_time_scale = true
	
	timer.start()
	
# All possible player colors
# FUTURE: Build state management system
enum color {
	RED,
	ORANGE,
	BLUE,
	GREEN
}

func jump(delta):
	var jump_height = timer_seconds * -speed / 2
	print(jump_height)
	
	movement_vector = movement_vector * jump_height
	print(movement_vector)
	
	velocity += movement_vector * delta
	
	
func _on_timer_timeout() -> void:
	timer_seconds += 1
	print(timer_seconds)
	
func show_trajectory(delta):
	line.clear_points()
	
	var pos = global_position
	var vel = (player_pos - mouse_pos) * -speed
	
	for i in max_points:
		line.add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
		# FIXME: Break the function if trajectory line touches a wall/ground

func _process(delta):
	player_pos = global_position
	mouse_pos = get_global_mouse_position()
	movement_vector = player_pos - mouse_pos 
	
func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("left_click"):
		timer.paused = false
		timer_seconds = 0
		line.show()
		show_trajectory(delta)

	if Input.is_action_just_released("left_click"):
		timer.paused = true
		line.hide()
		jump(delta)
	
	if movement_vector.length() > 0:
		movement_vector = movement_vector.normalized()
		
	position = position.clamp(Vector2.ZERO, screen_size)
	
	move_and_slide()
		
func change_color():
	pass
