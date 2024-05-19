class_name Throwable extends "res://Scripts/Pickable.gd"

var _friction : float = 4000
var _maxVelocity : float = 2000

func StopDrag() -> void:
	super.StopDrag()
	Throw()
	
func _process(_delta):
	super._process(_delta)
	if not _isDragging:
		ApplyFriction(_delta)
		MaximiseSpeed()
		position += _velocity*_delta

func Throw() -> void:
	_velocity = _lastVelocity / 2

func ApplyFriction(_delta) -> void:
	if _velocity.length() > 50:
		var direction = _velocity.normalized()
		_velocity = _velocity - direction * _friction * _delta
	else:
		_velocity = Vector2.ZERO

func MaximiseSpeed():
		var maxCurrentVelocity = max(abs(_velocity.x), abs(_velocity.y))
		if maxCurrentVelocity > _maxVelocity:
			_velocity = _velocity / maxCurrentVelocity * _maxVelocity
