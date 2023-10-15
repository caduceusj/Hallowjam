extends CharacterBody2D


const SPEED = 25
@onready var player_State = get_node("/root/PlayerState")
@export var player : Node2D

var health = 750

var isAlternating = false

var isWalking = true

var isAttacking = false

var onFire = false

var coolDown = 2.0

var attackCooldown = false

func _physics_process(delta):
	# Add the gravity.
	
	if(player):
		velocity.x = SPEED * sign(player.global_position.x - global_position.x)
		move_and_slide()
		if(velocity.x != 0):
				$AnimatedSprite2D.play("Walking")
				if(velocity.x > 0):
					$AnimatedSprite2D.flip_h = false
					$KarateHitBox/CollisionShape2D.position = Vector2(14.5, 16.5)
				if(velocity.x < 0):
					$AnimatedSprite2D.flip_h = true
					$KarateHitBox/CollisionShape2D.position = Vector2(-14.5, 16.5)
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
	if(player):
		if global_position.distance_to(player.global_position) < 100:
			velocity.x = 0
			$KarateHitBox.monitorable = true
			$AnimatedSprite2D.play("KarateAttack")
			await($AnimatedSprite2D.animation_finished)
			$KarateHitBox.monitorable = false
			await(get_tree().create_timer(0.5).timeout)
func _on_area_2d_area_entered(area):
	if(area.is_in_group("Player")):
		player = area.get_parent()



	



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


func _on_karate_hit_box_area_entered(area):
	if(area.is_in_group("Player")):
		player_State.currentHealth = player_State.currentHealth - 25
