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
	
func _process(delta):
	if (position.x > 1000 || position.x < -1000 || position.y > 1000 || position.y < -1000):
		queue_free()  

func _physics_process(delta):
	velocity = Vector2(0, speed).rotated(_direction)
	move_and_slide();

func _on_area_2d_body_entered(body):
	if (body.life < 0):
		return;
	body.life -= _damage;
	queue_free()
