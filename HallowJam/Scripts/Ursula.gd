extends CharacterBody2D


const SPEED = 300.0

@export var player : Node2D

enum STATE
{
	IDLE,
	RANGED_ATTACK,
	FLAMESTRIKE,
	KARATE
}


func _physics_process(delta):
	# Add the gravity.
	velocity.x = SPEED * sign(player.global_position.x - global_position.x)
	move_and_slide()
	if(velocity.x != 0):
		$AnimatedSprite2D.play("default")
		if(velocity.x > 0):
			$AnimatedSprite2D.flip_h = false
		if(velocity.x < 0):
			$AnimatedSprite2D.flip_h = true

func _on_area_2d_area_entered(area):
	pass # Replace with function body.
