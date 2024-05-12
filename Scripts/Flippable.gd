extends "res://Scripts/Pickable.gd"

var _frontTexture : CompressedTexture2D = load("res://Images/Card.jpg")
var _backTexture : CompressedTexture2D = load("res://Images/CardBack.jpg")

var _isFlipped : bool = false
var _flipAxis : int = 0 # 0=x, 1=y
var _originalScale : Vector2 = self.scale

func _on_input_event(_viewport, event, _shape_idx):
	super._on_input_event(_viewport, event, _shape_idx)
	if event is InputEventMouseButton:
		#Dragging camera
		if event.button_index == MOUSE_BUTTON_RIGHT:
			# Start dragging
			if _isDragging and event.pressed:
				StartFlip()

func StartFlip():
	_originalScale = Vector2(_currentScale, _currentScale)
	
	if _tween:
		_tween.kill()
	_tween = get_tree().create_tween()
	_tween.finished.connect(FlipHalfWay)
	_tween.tween_property(self, "scale", Vector2(0,_originalScale.y) if _flipAxis == 0 else Vector2(_originalScale.x,0), 0.15).set_trans(Tween.TRANS_LINEAR)

func FlipHalfWay():
	if (_isFlipped):
		$Texture.texture = _frontTexture
		_isFlipped = false
	else:
		$Texture.texture = _backTexture
		_isFlipped = true
	
	_originalScale = Vector2(_currentScale, _currentScale)
	
	if _tween:
		_tween.kill()
	_tween = get_tree().create_tween()
	_tween.tween_property(self, "scale", _originalScale, 0.15).set_trans(Tween.TRANS_LINEAR)
