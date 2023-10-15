extends Node2D
@onready var player_State = get_node("/root/PlayerState")

@export var checkpoint = 0


func _on_area_2d_area_entered(area):
	if(area.is_in_group("Player")):
		player_State.checkpoint = checkpoint
		
