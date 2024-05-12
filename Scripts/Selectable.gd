extends CharacterBody2D

func _on_mouse_entered():
	$Texture.material.set_shader_parameter("color", Vector4(1.0, 0.96, 0.7,1.0))


func _on_mouse_exited():
	$Texture.material.set_shader_parameter("color", Vector4(0.0, 0.0, 0.0, 0.5))
