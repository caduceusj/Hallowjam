extends Area2D


var vec4

func _on_area_entered(area):
	if area.is_in_group("Player"):
		var vec4 = Vector4(position.x, position.y, position.x+scale.x*256, position.y+scale.y*144)
		get_parent().cameraLimiter(vec4)
		pass
