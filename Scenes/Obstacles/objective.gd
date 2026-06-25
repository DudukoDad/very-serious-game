extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("Player touched objective (pause no diddy)")
		SignalMaster.game_win.emit()
