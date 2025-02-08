extends CharacterBody2D
@export var speed: int

func _ready():
	pass;

func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("test_right"):
		position.x += 1
	if Input.is_action_pressed("test_left"):
		position.x -= 1
	if Input.is_action_pressed("test_down"):
		position.y += 1
	if Input.is_action_pressed("test_up"):
		position.y -= 1
#	if velocity.length() > 0:
#		position += velocity * delta * speed
