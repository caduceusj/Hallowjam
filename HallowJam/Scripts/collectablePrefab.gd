extends Area2D

@export var item = "Axe"
@onready var State = get_node("/root/PlayerState")
# Called when the node enters the scene tree for the first time.

func _ready():
	if(item == "Axe"):
		$Sprite2D.frame = 0
	elif(item == "Flame"):
		$Sprite2D.frame = 1
	elif(item  == "Hammer"):
		$Sprite2D.frame = 2
	elif(item == "Web"):
		$Sprite2D.frame = 3
func _on_area_entered(area):
	if(area.is_in_group("Player")):
			State.currentItems.append(item)
			State.currentSkill = item
			queue_free()
	
