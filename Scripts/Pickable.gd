class_name Pickable extends "res://Scripts/Selectable.gd"

var _isDragging : bool = false
var _speed : float = 25
var _lastVelocity : Vector2
var _velocity : Vector2
var _pickUpOffset : Vector2

var _pickUpSize : float = 1.2
var _currentScale : float = 1.0

var _tween : Tween

var _orig_z_index : int = z_index
var _selected_z_index : int = 100

#True if something is stacked on top of this thing
var _stackedOnTop : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if _isDragging:
		var currentZoom = Global.GetZoom()
		var distance = position.distance_to(get_global_mouse_position()- _pickUpOffset) 
		var target = position.direction_to(get_global_mouse_position() - _pickUpOffset)
		if distance > 25:
			_velocity = target * distance * _speed / currentZoom
			_lastVelocity = _velocity / distance
		else:
			_velocity = Vector2(0,0)
			_lastVelocity = Vector2(0,0)
		#if collision:
			#CollisionHandler(collision.get_collider())
		
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			StopDrag()
			
	position += _velocity * _delta
	
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
	_pickUpOffset = position.direction_to(get_global_mouse_position())* position.distance_to(get_global_mouse_position())
	_isDragging = true
	_orig_z_index = z_index
	z_index = _selected_z_index
	
	var borderWidth = _texture.material.get_shader_parameter("width")
	_texture.material.set_shader_parameter("width", borderWidth*2)
	
	if _tween:
		_tween.kill()
	_tween = get_tree().create_tween()
	_tween.tween_property(self, "scale", Vector2(_pickUpSize, _pickUpSize) , 0.05).set_trans(Tween.TRANS_LINEAR)
	_currentScale = _pickUpSize
	
func StopDrag() -> void:
	_isDragging = false
	z_index = _orig_z_index
	print(_lastVelocity)
	_lastVelocity = _velocity
	_velocity = Vector2(0,0)
	
	
	var borderWidth = _texture.material.get_shader_parameter("width")
	_texture.material.set_shader_parameter("width", borderWidth/2)
	
	if _tween:
		_tween.kill()
	_tween = get_tree().create_tween()
	_tween.tween_property(self, "scale", Vector2(1.0, 1.0) , 0.05).set_trans(Tween.TRANS_LINEAR)
	_currentScale = 1.0

func Collided(collisionTarget : CharacterBody2D) -> void:
	set_collision_layer_value(2, 0)
	set_collision_layer_value(1, 0)
	print("collided")
	_stackedOnTop = true

func LeftCollision() -> void:
	pass

func CollisionHandler(collisionTarget : Area2D) -> void:
	if collisionTarget is Pickable:
		collisionTarget.Collided(self)
	
