class_name Player
extends CharacterBody2D

signal wall_hit

@export var speed: float = 100.0
@export var rotation_speed: float = 5.0
@export var gravity: float = 20.0

var wall_stick: bool = false
var jump_dir: Vector2 = Vector2.ZERO

@onready var line: Line2D = $Line2D
@onready var player_sprite: ColorRect = $PlayerSprite
@onready var jump_marker: Marker2D = $JumpDirection
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = 5.0
	timer.one_shot = false
	timer.ignore_time_scale = true
	timer.start()
	
	if not wall_hit.is_connected(_on_wall_hit):
		wall_hit.connect(_on_wall_hit)

func _physics_process(delta: float) -> void:
	jump_dir = jump_marker.position
	
	if not wall_stick:
		velocity.y += gravity
	else:
		velocity = Vector2.ZERO

	if Input.is_action_pressed("left_click"):
		timer.paused = false
		
		# Kept your original negative speed here to match your rotation math
		var marker_velocity = Vector2.UP.rotated(rotation) * -speed
		jump_marker.rotation += rotation_speed * delta
		jump_marker.position += marker_velocity * delta 
		
		look_at(global_position + jump_dir)
		
	if Input.is_action_just_released("left_click"):
		timer.paused = true
		if wall_stick:
			var wall_normal = get_wall_normal()
			if wall_normal != Vector2.ZERO:
				global_position += wall_normal * 2.0
			else:
				global_position -= jump_dir.normalized() * 2.0
				
			wall_stick = false
			
		jump()

	move_and_slide()

func jump() -> void:
	var movement_vector = jump_marker.position
	# Multiplied by -1 to invert the magnitude so you shoot towards the marker
	var jump_vel = (speed * movement_vector) / 3
	velocity = jump_vel
	
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self:
		wall_hit.emit()

func _on_wall_hit() -> void:
	wall_stick = true
	velocity = Vector2.ZERO
	jump_marker.position = Vector2.ZERO
	jump_marker.rotation = 0
	
	if not Input.is_action_pressed("left_click"):
		rotation = 0
		
	$Area2D/CollisionShape2D.set_deferred("disabled", true)

func _on_timer_timeout() -> void:
	pass
