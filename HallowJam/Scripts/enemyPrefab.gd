extends CharacterBody2D


var speed = 50  # Ajuste para corresponder ao seu jogo
var player : Node2D

var health = 75

enum State {
	PATROL,
	CHASE
}


func _ready():
	pass

func _physics_process(delta):
	if(player):
		velocity.x = speed * sign(player.global_position.x - global_position.x)
	move_and_slide()
	if(velocity.x != 0):
		$AnimatedSprite2D.play("default")
		if(velocity.x > 0):
			$AnimatedSprite2D.flip_h = false
		if(velocity.x < 0):
			$AnimatedSprite2D.flip_h = true
	else:
		patrol()
		


func patrol():
		velocity.x = +10
		await(get_tree().create_timer(3.0).timeout)
		velocity.x = 0
		velocity.x = -10
		await(get_tree().create_timer(3.0).timeout)
		velocity.x = 0

func _on_area_2d_area_entered(area):
	if(area.is_in_group("Player")):
		player = area.get_parent()
	
		


func _on_bullet_and_area_area_entered(area):
	if(area.is_in_group("bullet")):
		print("enter")
		area.get_parent().queue_free()
		health = health - 25
		$AnimationPlayer.play("Damaged")
		if(health <= 0):
			$BulletAndArea.monitoring = false
			$AnimationPlayer.play("death")
			await($AnimationPlayer.animation_finished)
			queue_free()
