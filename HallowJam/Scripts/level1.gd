extends Node2D

@export var camera : Camera2D


@export var cameraLimit : Vector4
# Called when the node enters the scene tree for the first time.
@export var player : Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	camera.position = lerp(camera.position, player.position, 0.5)
	

