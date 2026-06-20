extends BaseLevel

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var level_camera: Camera2D = $Camera2D

# Implementing BaseLevel abstract class
func get_default_player_spawn() -> Vector2:
	# Checks for spawn marker thing, then returns position
	if spawn_point:
		return spawn_point.global_position
	# Makes sure character is not moving
	return Vector2.ZERO

# Returns the level camera	
func get_player_camera() -> Camera2D:
	return level_camera
