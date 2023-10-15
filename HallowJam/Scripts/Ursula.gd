extends CharacterBody2D


const SPEED = 25

@export var player : Node2D

var isAlternating = false

var isWalking = true

var isAttacking = false



func _physics_process(delta):
	# Add the gravity.
	if(player):
		if(not isAttacking):
			velocity.x = SPEED * sign(player.global_position.x - global_position.x)
			move_and_slide()
			if(velocity.x != 0):
				$AnimatedSprite2D.play("Walking")
				if(velocity.x > 0):
					$AnimatedSprite2D.flip_h = false
				if(velocity.x < 0):
					$AnimatedSprite2D.flip_h = true
		if(isAttacking):
			velocity.x = 0
			if global_position.distance_to(player.global_position) < 50:
				$AnimatedSprite2D.play("KarateAttack")
		if(isAlternating == false):
			alternate()
func _on_area_2d_area_entered(area):
	if(area.is_in_group("Player")):
		player = area.get_parent()

func alternate():
	await(get_tree().create_timer(2.5).timeout)
	isAlternating = true
	isWalking = true
	await(get_tree().create_timer(2.5).timeout)
	isWalking = false
	isAttacking = true
	isAlternating = false
	
