@tool
extends StaticBody2D

func _ready() -> void:
	if not Engine.is_editor_hint():
		var coll := CollisionPolygon2D.new()
		coll.polygon = $Polygon2D.polygon
		add_child(coll)

func _process(delta: float) -> void:
	pass
