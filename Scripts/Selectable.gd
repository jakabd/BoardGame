class_name Selectable extends Area2D

@export var _texture : Node2D

func _on_mouse_entered():
	if _texture:
		_texture.material.set_shader_parameter("color", Vector4(1.0, 0.96, 0.7,1.0))

func _on_mouse_exited():
	if _texture:
		_texture.material.set_shader_parameter("color", Vector4(0.0, 0.0, 0.0, 0.5))
