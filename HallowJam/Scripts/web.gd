extends AnimatedSprite2D

@export var webDamage = 25

func _ready():
	await(get_tree().create_timer(2.0).timeout)
	queue_free()
