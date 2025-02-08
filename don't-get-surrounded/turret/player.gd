extends Node2D
@export var speed: int
var life = -1

func _ready():
	add_to_group("player")
	$Area2D.add_to_group("player")

func _process(delta):
	$Player.look_at(get_global_mouse_position())
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("test_right"):
		velocity.x += 1
	if Input.is_action_pressed("test_left"):
		velocity.x -= 1
	if Input.is_action_pressed("test_down"):
		velocity.y += 1
	if Input.is_action_pressed("test_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		position += velocity.normalized() * delta * speed
