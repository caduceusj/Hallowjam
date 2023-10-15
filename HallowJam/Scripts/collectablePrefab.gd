extends Area2D

@export var isAxe = true
@export var isFireball = false

# Called when the node enters the scene tree for the first time.


func _on_area_entered(area):
	if(area.is_in_group("Player")):
		if(isAxe == true):
			area.get_parent().justAcquiredAxe = true
			queue_free()
