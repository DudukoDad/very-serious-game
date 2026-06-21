@abstract
class_name BaseLevel
extends Node2D
## Abstract class for levels

## Provides a player spawn location
@abstract func get_default_player_spawn() -> Vector2

## Provides camera used in level
@abstract func get_player_camera() -> Camera2D
