extends Sprite2D

@export var _polygon : PackedVector2Array 
@export var _color : Color 

func _draw():
	draw_line(Vector2(1.5, 1.0), Vector2(1.5, 4.0), Color.GREEN, 1.0)
	draw_line(Vector2(4.0, 1.0), Vector2(4.0, 4.0), Color.GREEN, 2.0)
	draw_line(Vector2(7.5, 1.0), Vector2(7.5, 4.0), Color.GREEN, 3.0)
	if _polygon:
		draw_polygon(_polygon, [_color])
		print("draw")
