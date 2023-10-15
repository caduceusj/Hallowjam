extends CharacterBody2D



var SPEED = 150.0
var JUMP_VELOCITY = -400.0



var directionBullet = Vector2(1,0)

@export var camera : Camera2D

@onready var player_State = get_node("/root/PlayerState")
@onready var bullet = preload("res://Cenas/bullet.tscn")
@onready var web = preload("res://Cenas/Bullets/web.tscn")
@onready var axe = preload("res://Cenas/Bullets/axe.tscn")


var fireOn = false
var inMeleeArea = false
var coolDown = 2.0
var bullet_point : Node2D
var target : Node2D
var justAcquiredAxe
var canFire = true
var canSkill = true
var isHittingHammer = false
var canReceiveDamage = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1300

func _ready():
	bullet_point = $bulletPoint
	


func _process(delta):
	if(inMeleeArea and canReceiveDamage):
		canReceiveDamage = false
		$AudioStreamPlayer.stream = load("res://SFX/Character/damage.ogg")
		$AudioStreamPlayer.play(0.0)
		player_State.currentHealth = player_State.currentHealth - 20
		if(player_State.currentHealth <= 0):
			get_tree().change_scene_to_file("res://Menu/Cenas/game_over.tscn")
		$AnimationPlayer.play("Damaged")
		await($AnimationPlayer.animation_finished)
		canReceiveDamage = true
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		$AnimatedSprite2D.play("Jumping")
		velocity.y += gravity * delta
	
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		isHittingHammer = false
		$Martelo.hide()
		$AudioStreamPlayer.stream = load("res://SFX/Character/Jump.ogg")
		$AudioStreamPlayer.play(0.0)
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if(not is_on_floor() or isHittingHammer == false):
			$AnimatedSprite2D.play("Walking")
			direction = direction * SPEED
			velocity.x = lerp(velocity.x, direction, 0.2)#direction * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)#move_toward(velocity.x, 0, SPEED)
		if(not is_on_floor()):
			pass
		else:
			if(isHittingHammer):
				pass
			else:
				$AnimatedSprite2D.play("Idle")
	move_and_slide()
	
func fire():
	if(canFire):
		canFire = false
		$AudioStreamPlayer.stream = load("res://SFX/Character/Shoot.ogg")
		$AudioStreamPlayer.play(0.0)
		var bulletShoot = bullet.instantiate()
		bulletShoot.global_position = bullet_point.global_position
		bulletShoot.direction = directionBullet
		get_tree().root.add_child(bulletShoot)
		await(get_tree().create_timer(0.5).timeout)
		canFire = true
	
func skillShot():
		$AudioStreamPlayer.stream = load("res://SFX/Character/axe_throw.ogg")
		$AudioStreamPlayer.play(0.0)
		var axeShot = axe.instantiate()
		axeShot.global_position = bullet_point.global_position
		axeShot.direction = directionBullet
		get_tree().root.add_child(axeShot)
		await(get_tree().create_timer(axeShot.coolDown).timeout)

func webJump():
	$AnimationPlayer.play("WeebStrike")
	$AudioStreamPlayer.stream = load("res://SFX/Character/Web.ogg")
	await(get_tree().create_timer(0.20).timeout)
	$AudioStreamPlayer.play(0.0)
	await($AnimationPlayer.animation_finished)
	var webSpawn = web.instantiate()
	webSpawn.global_position = global_position 
	get_tree().root.add_child(webSpawn)
	$AudioStreamPlayer.stream = load("res://SFX/Character/Jump.ogg")
	$AudioStreamPlayer.play(0.0)

	velocity.y = -300
	await(get_tree().create_timer(0.50).timeout)
	velocity.y = -600


	isHittingHammer = false


func flamethrower():
	print("ENTROU")
	
	$AudioStreamPlayer.stream = load("res://SFX/Weapons/HallowJam23_-_Track_02_Flamethrower.wav")
	$AudioStreamPlayer.play(0.0)
	$Fire.play("default")
	fireOn = true
	$Fire.visible = true
	await($AudioStreamPlayer.finished)
	#await(get_tree().create_timer(2.0).timeout)
	fireOn = false
	$Fire.visible = false


func _input(event):
	if(event.is_action_pressed("ui_shoot")):
		fire()
	if(event.is_action_pressed("ui_right") and isHittingHammer == false):
		directionBullet = Vector2(1,0)
		bullet_point.position = Vector2(14,-5)
		$AnimatedSprite2D.flip_h = false
		#fireFlip
		$Fire.position = Vector2(36,-4)
		$Fire.flip_h = false
	if(event.is_action_pressed("ui_left") and isHittingHammer == false):
		directionBullet = Vector2(-1,0)
		bullet_point.position = Vector2(-14,-5)
		$AnimatedSprite2D.flip_h = true
		#fireFlip
		$Fire.position = Vector2(-36,-4)
		$Fire.flip_h = true
	if(event.is_action_pressed("ui_change_skill") and player_State.hasSkill):
		var aux = player_State.currentItems.find(player_State.currentSkill)
		if(aux + 1 >= player_State.currentItems.size()):
			aux = 0
		else:
			aux = aux + 1
		player_State.currentSkill = player_State.currentItems[aux]
	if(event.is_action_pressed("ui_skill") and canSkill):
		if(player_State.currentSkill == "Axe"):
			skillShot()
		if(player_State.currentSkill == "Flame"):
			flamethrower()
		if(player_State.currentSkill == "Hammer" and is_on_floor()):
			velocity.x = 0
			isHittingHammer = true
			$AnimationPlayer.speed_scale = 1.5
			$AudioStreamPlayer.stream = load("res://SFX/Weapons/Hammer.ogg")
			$AudioStreamPlayer.play(0.0)
			if($AnimatedSprite2D.flip_h == false):
				$AnimationPlayer.play("HammerStrike")
			else:
				$AnimationPlayer.play("HammerStrikeLeft")
			JUMP_VELOCITY = -550
			await($AnimationPlayer.animation_finished)
			isHittingHammer = false
			print("itsOver")
			JUMP_VELOCITY = -400
		if(player_State.currentSkill == "Web" and is_on_floor()):
			isHittingHammer = true
			webJump()
		canSkill = false
		await(get_tree().create_timer(coolDown).timeout)
		canSkill = true
			
			
			
	


func _on_area_2d_area_entered(area):
	if(area.is_in_group("Enemy")):
		inMeleeArea = true
	
	if(area.is_in_group("enemyBullet")):
		area.get_parent().queue_free()
		canReceiveDamage = false
		$AudioStreamPlayer.stream = load("res://SFX/Character/damage.ogg")
		$AudioStreamPlayer.play(0.0)
		player_State.currentHealth = player_State.currentHealth - 20
		if(player_State.currentHealth <= 0):
			get_tree().change_scene_to_file("res://Menu/Cenas/game_over.tscn")
		$AnimationPlayer.play("Damaged")
		await($AnimationPlayer.animation_finished)
		canReceiveDamage = true
		


func _on_area_2d_area_exited(area):
	if(area.is_in_group("Enemy")):
		inMeleeArea = false
