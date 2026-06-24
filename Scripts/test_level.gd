extends BaseLevel

@onready var spawn_point: Marker2D = $SpawnPoint

# Implementing BaseLevel abstract class
func get_default_player_spawn() -> Vector2:
	# Checks for spawn marker thing, then returns position
	if spawn_point:
		return spawn_point.global_position
	# Makes sure character is not moving
	return Vector2.ZERO
