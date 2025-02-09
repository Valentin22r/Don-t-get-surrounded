extends StaticBody2D

@export var timer: Timer

var generate: int = 3;
var upgrade_count: int = 0;
var is_player_around: bool = false

var workspeed: int = 0

var hp: int = 100
var life: int = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_count = 0;
	is_player_around = false
	generate = 3
	add_to_group("building")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("Upgrade") && is_player_around):
		upgrade_count += 1;
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
	if (hp < 100):
		hp += workspeed
		GlobalData.power -= workspeed
		if (hp > 100):
			hp == 100;
	if (hp < 0):
		return;
	GlobalData.power += generate + (0.25 * workspeed) + upgrade_count
