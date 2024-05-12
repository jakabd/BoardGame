extends CharacterBody2D

var _isDragging : bool = false
var _lastMousePos : Vector2
var _lastPos : Vector2

var _pickUpSize = 1.2

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
	scale = Vector2(_pickUpSize, _pickUpSize)
	
func StopDrag() -> void:
	_isDragging = false
	scale = Vector2(1.0, 1.0)
	
func _on_mouse_entered():
	pass # Replace with function body.


func _on_mouse_exited():
	pass # Replace with function body.
