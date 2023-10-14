extends CharacterBody2D



const SPEED = 150.0
const JUMP_VELOCITY = -400.0

var directionBullet = Vector2(1,0)


@onready var bullet = preload("res://Cenas/bullet.tscn")
@onready var axe = preload("res://Cenas/Bullets/axe.tscn")
var bullet_point : Node2D
var target : Node2D
var justAcquiredAxe
var canFire = true
var canSkill = true


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1300

func _ready():
	bullet_point = $bulletPoint



func _process(delta):
	if(justAcquiredAxe == true):
		justAcquiredAxe = false
		$Control.show()
		$Control/MarginContainer/Panel/Label.text = "Muhehehehe noo i dont have anything to say"
		await(get_tree().create_timer(3.0).timeout)
		$Control.hide()
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		$AnimatedSprite2D.play("Jumping")
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if(not is_on_floor()):
			pass
		else:
			$AnimatedSprite2D.play("Walking")
		direction = direction * SPEED
		velocity.x = lerp(velocity.x, direction, 0.2)#direction * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)#move_toward(velocity.x, 0, SPEED)
		if(not is_on_floor()):
			pass
		else:
			$AnimatedSprite2D.play("Idle")
	move_and_slide()
	
func fire():
	if(canFire):
		canFire = false
		var bulletShoot = bullet.instantiate()
		bulletShoot.global_position = bullet_point.global_position
		bulletShoot.direction = directionBullet
		get_tree().root.add_child(bulletShoot)
		await(get_tree().create_timer(bulletShoot.coolDown).timeout)
		canFire = true
	
func skillShot():
	if(canSkill):
		canSkill = false
		var axeShot = axe.instantiate()
		axeShot.global_position = bullet_point.global_position
		axeShot.direction = directionBullet
		get_tree().root.add_child(axeShot)
		await(get_tree().create_timer(axeShot.coolDown).timeout)
		canSkill = true
	
func _input(event):
	if(event.is_action_pressed("ui_shoot")):
		fire()
	if(event.is_action_pressed("ui_right")):
		directionBullet = Vector2(1,0)
		bullet_point.position = Vector2(14,-5)
		$AnimatedSprite2D.flip_h = false
	if(event.is_action_pressed("ui_left")):
		directionBullet = Vector2(-1,0)
		bullet_point.position = Vector2(-14,-5)
		$AnimatedSprite2D.flip_h = true
	if(event.is_action_pressed("ui_skill")):
		skillShot()
