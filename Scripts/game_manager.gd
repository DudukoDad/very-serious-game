extends Node

# Node References
# MainGame for loading levels
@onready var main_game: MainGame = $"../.."

# Player

# Obstacles

# Goal/Objectives

# States
enum State {ACTIVE, WIN, LOSS, PAUSE}
@onready var current_state = State.ACTIVE

# Other variables
var current_level : int 

# State machine
func _process(delta):
	match current_state:
		State.ACTIVE:
			# Player starts the game
			get_tree().paused = false
			print('GameState: Active')
		State.WIN:
			# If player collides w/ end goal
			win()
			print('GameState: Win')
		State.LOSS:
			# Player collides w/ obstacle or falls out of map
			loss()
			print('GameState: Loss')
		State.PAUSE:
			# Player presses the pause key
			pause()
			print('GameState: Pause')
			
func win():
	# TODO
	# 1. Prompt to go to next level
	# 2. Load the next level on prompt completion
	# 3. If the last level has been reached, game over
	pass

func loss():
	# TODO
	# 1. Prompt "R" to restart (restart from level 1)
	current_level = 0
	
func pause():
	get_tree().paused = true
