extends RigidBody2D

@export var speed = 400  # Ajuste para corresponder ao seu jogo
var direction = Vector2(-1, 0)  # Ajuste para a direção que você deseja

@export var damage = 25

@export var coolDown = 3.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("bullet")
	apply_central_impulse(direction * speed)
	await(get_tree().create_timer(5.0).timeout)
	queue_free()
