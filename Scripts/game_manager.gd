extends Node

enum State {ACTIVE, WIN, LOSS, PAUSE}

var current_state : State = State.ACTIVE:
	set(value):
		current_state = value
		_on_state_changed(current_state)

# Other variables
var current_level : int = 1

func _ready():
	current_state = State.ACTIVE
	
	SignalMaster.game_over.connect(_on_game_over)
	SignalMaster.game_win.connect(_on_game_win)
	#_on_state_changed(current_state)
	
# State machine
func _on_state_changed(current_state: State):
	match current_state:
		State.ACTIVE:
			# Player starts the game
			get_tree().paused = false
			print('GameState: Active')
		State.WIN:
			# If player collides w/ end goal
			print('GameState: Win')
		State.LOSS:
			# Player collides w/ obstacle or falls out of map
			current_level = 0
			print('GameState: Loss')
		State.PAUSE:
			# Player presses the pause key
			print('GameState: Pause')
			
func _on_game_win():
	# TODO
	# 1. Prompt to go to next level
	# 2. Load the next level on prompt completion
	# 3. If the last level has been reached, game over
	current_state = State.WIN

func _on_game_over():
	# TODO
	# 1. Prompt "R" to restart (restart from level 1)
	current_state = State.LOSS
	
func _on_game_pause():
	get_tree().paused = true
	current_state = State.PAUSE
