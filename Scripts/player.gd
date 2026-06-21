class_name Player
extends RigidBody2D

@onready var velocity = Vector2.ZERO
@onready var speed = 5

# All possible player colors
# FUTURE: Build state management system
enum colors {
	RED,
	ORANGE,
	BLUE,
	GREEN
}
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			jump()

func jump():
	# Calculate vector between players current position and mouse cursor
	var vector = global_position - get_global_mouse_position()
	print(vector)
	
	# Multiply vector by -1 to invert the magnitude
	var movement_vector = vector * speed
	movement_vector.normalized()
	
	apply_impulse(Vector2(movement_vector))
	
	
	
