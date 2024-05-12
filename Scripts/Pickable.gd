extends "res://Scripts/Selectable.gd"

var _isDragging : bool = false
var _lastMousePos : Vector2
var _lastPos : Vector2

var _pickUpSize : float = 1.2
var _currentScale : float = 1.0

var _tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if _isDragging:
		var mousePos = get_viewport().get_mouse_position()
		var mouseMovement = Vector2(mousePos.x - _lastMousePos.x, mousePos.y - _lastMousePos.y)
		var currentZoom = Global.GetZoom()
		set_position(Vector2(_lastPos.x + mouseMovement.x/currentZoom, _lastPos.y + mouseMovement.y/currentZoom))


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		#Dragging camera
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Start dragging
			if not _isDragging and event.pressed:
				StartDrag()
			# Stop dragging if the button is released.
			if _isDragging and not event.pressed:
				StopDrag()


func StartDrag() -> void:
	_isDragging = true
	_lastMousePos = get_viewport().get_mouse_position()
	_lastPos = self.get_position()
	var borderWidth = $Texture.material.get_shader_parameter("width")
	$Texture.material.set_shader_parameter("width", borderWidth*5)
	
	if _tween:
		_tween.kill()
	_tween = get_tree().create_tween()
	_tween.tween_property(self, "scale", Vector2(_pickUpSize, _pickUpSize) , 0.05).set_trans(Tween.TRANS_LINEAR)
	_currentScale = _pickUpSize
	
func StopDrag() -> void:
	_isDragging = false
	var borderWidth = $Texture.material.get_shader_parameter("width")
	$Texture.material.set_shader_parameter("width", borderWidth/5)
	
	if _tween:
		_tween.kill()
	_tween = get_tree().create_tween()
	_tween.tween_property(self, "scale", Vector2(1.0, 1.0) , 0.05).set_trans(Tween.TRANS_LINEAR)
	_currentScale = 1.0
