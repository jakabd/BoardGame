extends Node

var _currentZoom : float = 1.0
var _minZoom : float = 0.5
var _maxZoom : float = 2.0
var _zoomSpeed : float = 0.1

func GetZoom() -> float:
	return _currentZoom
	
func SetZoom(zoomVal : float) -> float:
	if _minZoom < zoomVal and zoomVal < _maxZoom:
		_currentZoom = zoomVal
	return _currentZoom
	
func ZoomIn() -> float:
	self.SetZoom(self.GetZoom() + _zoomSpeed)
	return self.GetZoom()
	
func ZoomOut() -> float:
	self.SetZoom(self.GetZoom() - _zoomSpeed)
	return self.GetZoom()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
