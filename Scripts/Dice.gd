extends "res://Scripts/Throwable.gd"

var _maxNumber : int = 12
var _sides : int = 6
var _size : int = 100
var _color : Color = Color("ffffff")
var _currentNumber : int = 1

var _polygon : PackedVector2Array

func _process(_delta):
	super._process(_delta)
	if randi_range(1,100) == 1:
		Reroll()

func _draw():
	if not _polygon:
		_polygon = CreatePolygon()
	draw_polygon(_polygon, [_color])

func Reroll():
	_currentNumber = randi_range(1, _maxNumber)
	$NumberLabel.text = str(_currentNumber)
	
func CreatePolygon() -> PackedVector2Array:
	var vertices : PackedVector2Array = []
	for point in range(0,_sides):
		var angle = (point/float(_sides))*PI*2
		#Rotate even polygons by half the angle between two vertices, so they have a flat edge down/upwards
		if _sides % 2 == 0:
			angle = angle + 1./_sides*PI
		var vertex = Vector2(sin(angle)*_size, cos(angle)*_size)
		print(vertex)
		vertices.append(vertex)
	return vertices
