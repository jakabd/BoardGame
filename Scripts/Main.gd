extends Node

@onready var _mainCamera: Camera2D = $Camera2D
@onready var _viewPortSize : Vector2 = get_viewport().get_visible_rect().size

# Camera parameters
var _cameraSpeed : float = 0.01

#Mouse movement
var _lastMousePos : Vector2
var _lastCameraPos : Vector2
var _isCameraDragging : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_mainCamera.position_smoothing_enabled = true
	_mainCamera.make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	MoveCameraHover(get_viewport().get_mouse_position())
	MoveCameraDrag(get_viewport().get_mouse_position())

func _unhandled_input(event):
	if event is InputEventMouseButton:
		#Zoom in
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			var zoom = Global.ZoomIn()
			_mainCamera.set_zoom(Vector2(zoom, zoom))
		#Zoom out
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			var zoom = Global.ZoomOut()
			_mainCamera.set_zoom(Vector2(zoom, zoom))
		#Dragging camera
		if event.button_index == MOUSE_BUTTON_RIGHT:
			# Start dragging
			if not _isCameraDragging and event.pressed:
				_isCameraDragging = true
				_lastMousePos = get_viewport().get_mouse_position()
				_lastCameraPos = _mainCamera.get_position()
			# Stop dragging if the button is released.
			if _isCameraDragging and not event.pressed:
				_isCameraDragging = false
	

#Move camera if it is going to side of the screen
func MoveCameraHover(mousePos : Vector2) -> void:
	if _viewPortSize.x*3/4 < mousePos.x or mousePos.x < _viewPortSize.x/4 or _viewPortSize.y*3/4 < mousePos.y or mousePos.y < _viewPortSize.y/4:
		var currentZoom = Global.GetZoom()
		var newLoc = Vector2(_mainCamera.get_position().x + (mousePos.x - _viewPortSize.x/2)*_cameraSpeed/currentZoom, _mainCamera.get_position().y + (mousePos.y - _viewPortSize.y/2)*_cameraSpeed/currentZoom)
		_mainCamera.set_position(newLoc)

#Move camera by dragging
func MoveCameraDrag(mousePos : Vector2) -> void:
	if _isCameraDragging:
		var currentZoom = Global.GetZoom()
		var mouseMovement = Vector2(_lastMousePos.x - mousePos.x, _lastMousePos.y - mousePos.y)/currentZoom
		_mainCamera.set_position(Vector2(_lastCameraPos.x + mouseMovement.x, _lastCameraPos.y + mouseMovement.y))


func _on_card_mouse_entered():
	pass # Replace with function body.
