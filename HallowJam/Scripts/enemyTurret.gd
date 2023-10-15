extends CharacterBody2D

var health = 125
var onFire = false
var canShoot = true

var directionPlayer : Vector2
@onready var bullet = preload("res://Cenas/Enemy/enemyTurretBullet.tscn")

@export var player : Node2D

func _ready():
	$Bullet.play("bullet")
	$AnimatedSprite2D.play("Idle")

func _physics_process(delta):
	if(player):
		var variavelAi = sign(player.position.x - position.x)
		if(variavelAi > 0):
			$AnimatedSprite2D.flip_h = false
		elif(variavelAi < 0):
			$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D/BulletPoint.position = Vector2(12*variavelAi,0)
		$Bullet.position = Vector2(12*variavelAi,0)
		directionPlayer = Vector2(1*variavelAi,0)
		if(canShoot):
			shoot()
			canShoot = false
	
func _process(delta):
	if(onFire):
		await(get_tree().create_timer(1.0).timeout)
		health = health - 25
		if(health <= 0):
			$BulletAndArea.monitoring = false
			$AnimationPlayer.play("death")
			await($AnimationPlayer.animation_finished)
			queue_free()
		$AnimationPlayer.play("Damaged")

func shoot():
	$AnimatedSprite2D.play("Shooting")
	await($AnimatedSprite2D.animation_finished)
	$AnimationPlayer.play("BulletLoad")
	await($AnimationPlayer.animation_finished)
	var ball = bullet.instantiate()
	ball.global_position = $AnimatedSprite2D/BulletPoint.global_position
	ball.direction = directionPlayer
	get_tree().root.add_child(ball)
	canShoot = true
	


func _on_bullet_and_area_area_entered(area):
	if(area.is_in_group("bullet")):
		print("enter")
		area.get_parent().queue_free()
		health = health - area.get_parent().damage
		$AnimationPlayer.play("Damaged")
		if(health <= 0):
			$BulletAndArea.monitoring = false
			$AnimationPlayer.play("death")
			await($AnimationPlayer.animation_finished)
			queue_free()
	elif(area.is_in_group("Fire")):
		if((area.get_parent()).get_parent().fireOn == true):
			onFire = true
			$AnimationPlayer.play("Damaged")
	elif(area.is_in_group("Hammer")):
		health = health - 75
		$AnimationPlayer.play("Damaged")
		if(health <= 0):
			$BulletAndArea.monitoring = false
			$AnimationPlayer.play("death")
			await($AnimationPlayer.animation_finished)
			queue_free()
	elif(area.is_in_group("Web")):
		health = health - 50
		$AnimationPlayer.play("Damaged")
		if(health <= 0):
			$BulletAndArea.monitoring = false
			$AnimationPlayer.play("death")
			await($AnimationPlayer.animation_finished)
			queue_free()


func _on_bullet_and_area_area_exited(area):
	if(area.is_in_group("Fire")):
		onFire = false


func _on_detection_area_area_exited(area):
	if(area.is_in_group("Player")):
		player = null



func _on_detection_area_area_entered(area):
	if(area.is_in_group("Player")):
		player = area.get_parent()

