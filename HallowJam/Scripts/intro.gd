extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("TitleRoll")
	$AnimationPlayer.speed_scale = 0.5
	pass # Replace with function body.

