extends Node2D

@export var camera : Camera2D

@onready var player_State = get_node("/root/PlayerState")
@export var cameraLimit : Vector4
# Called when the node enters the scene tree for the first time.
@export var player : Node2D

func _ready():
	$AudioStreamPlayer.stream = load("res://SFX/OST/Witch_Hunt.ogg")
	$AudioStreamPlayer.play(0.0)
	if(player_State.checkpoint == 1):
		player.position = $CheckPoints/CheckPoint.position
	if(player_State.checkpoint == 2):
		player.position = $CheckPoints/CheckPoint2.position
	if(player_State.checkpoint == 3):
		player.position = $CheckPoints/CheckPoint3.position
	if(player_State.checkpoint == 4):
		player.position = $CheckPoints/CheckPoint4.position
	if(player_State.checkpoint == 5):
		player.position = $CheckPoints/CheckPoint5.position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	camera.position = lerp(camera.position, player.position, 0.5)
	camera.position.x = clamp(camera.position.x, cameraLimit.x+128, cameraLimit.z-128)
	camera.position.y = clamp(camera.position.y, cameraLimit.y+72, cameraLimit.w-72)
	
func cameraLimiter(vec4 : Vector4 ):
	cameraLimit = vec4
	







func _on_song_area_area_entered(area):
	if(area.is_in_group("player")):
		$AudioStreamPlayer.stream = load("res://SFX/OST/Ursula.ogg")
		$AudioStreamPlayer.play(0.0)
