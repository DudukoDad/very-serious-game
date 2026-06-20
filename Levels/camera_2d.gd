extends Camera2D

var target: Node2D = null

func _process(_delta):
	if target:
		global_position = target.global_position
