extends Node2D

@export var camera : Camera2D


@export var cameraLimit : Vector4
# Called when the node enters the scene tree for the first time.
@export var player : Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	camera.position = lerp(camera.position, player.position, 0.5)
	camera.position.x = clamp(camera.position.x, cameraLimit.x+128, cameraLimit.z-128)
	camera.position.y = clamp(camera.position.y, cameraLimit.y+72, cameraLimit.w-72)
	
func cameraLimiter(vec4 : Vector4 ):
	cameraLimit = vec4
	


