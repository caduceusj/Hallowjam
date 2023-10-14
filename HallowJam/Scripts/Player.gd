extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -800.0


@onready var bullet = preload("res://Cenas/bullet.tscn")
var bullet_point : Node2D
var target : Node2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1300

func _ready():
	bullet_point = $bulletPoint


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		direction = direction * SPEED
		velocity.x = lerp(velocity.x, direction, 0.2)#direction * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)#move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func fire():
	var bulletShoot = bullet.instantiate()
	bulletShoot.global_position = bullet_point.global_position
	get_tree().root.add_child(bulletShoot)
	bulletShoot.apply_impulse(Vector2.ZERO, Vector2(100000, 0))  # Apply an impulse to the right
	
func _input(event):
	if(event.is_action_pressed("ui_shoot")):
		fire()
