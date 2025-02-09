extends StaticBody2D

@export var timer: Timer

var generate: int = 3;
var is_player_around: bool = false

var workspeed: int = 0

var hp: int = 100
var life: int = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	is_player_around = false
	generate = 3
	add_to_group("building")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("Interact") && is_player_around):
		## UPGRADE HERE
		pass
	pass;


func _on_area_2d_body_entered(body):
	if (body.is_in_group("drone")):
		workspeed += 1;
	if(body.is_in_group("player")):
		is_player_around = true;

func _on_area_2d_body_exited(body):
	if (body.is_in_group("drone")):
		workspeed -= 1;
	if(body.is_in_group("player")):
		is_player_around = false;

func _on_timer_timeout():
	GlobalData.power += generate + (0.2 * workspeed)
