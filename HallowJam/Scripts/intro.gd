extends Control
@onready var player_State = get_node("/root/PlayerState")
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("TitleRoll")
	$AnimationPlayer.speed_scale = 0.75
	$BackgroundMusic.play(0.0)
	$VoiceAudioStream.stream = load("res://SFX/Intro/Voz.wav")
	$VoiceAudioStream.play(0.0)
	$AnimatedSprite2D.play("default")
	await($VoiceAudioStream.finished)
	$VoiceAudioStream.stream = load("res://SFX/Intro/Voz_2.wav")
	$VoiceAudioStream.play(0.0)
	await($VoiceAudioStream.finished)
	$VoiceAudioStream.stream = load("res://SFX/Intro/Voz_3.wav")
	$VoiceAudioStream.play(0.0)
	await($VoiceAudioStream.finished)
	await($AnimationPlayer.animation_finished)
	player_State.currentHealth = 100
	get_tree().change_scene_to_file("res://Cenas/test.tscn")
	pass # Replace with function body.
	
func _input(event):
	if(event.is_action_pressed("ui_shoot")):
		player_State.currentHealth = 100
		get_tree().change_scene_to_file("res://Cenas/test.tscn")

