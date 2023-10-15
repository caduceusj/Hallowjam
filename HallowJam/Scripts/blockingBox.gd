extends Node


# Called when the node enters the scene tree for the first time.



func _on_area_2d_area_entered(area):
	if(area.is_in_group("Fire") and (area.get_parent().get_parent()).fireOn == true):
		queue_free()
	if(area.is_in_group("Axe")):
		queue_free()
		
