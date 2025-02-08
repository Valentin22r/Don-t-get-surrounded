extends CharacterBody2D

@export var speed: int

var _direction: float
var _origin: Vector2
var _rotation: float
var _damage: int
var _zindex: int

func _ready():
	add_to_group("bullets")
	global_position = _origin;
	global_rotation = _rotation;
	z_index = _zindex;
	
func _physics_process(delta):
	velocity = Vector2(0, speed).rotated(_direction)
	move_and_slide();

func _on_area_2d_body_entered(body):
	print("HIT")
	body.life -= _damage;
	queue_free()
