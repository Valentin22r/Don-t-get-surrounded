extends StaticBody2D

class_name Ship
signal DepartureChanged

@export var timer: Timer

var upgrade_count : int = 0
var workspeed: int = 0;
var ship_departure: int = 1800;
var act_debt: int = 0;
var is_player_around: bool = false;

var hp: int = 500
var life: int = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_count = 0;
	is_player_around = false
	add_to_group("building")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (hp < 0):
		get_tree().change_scene_to_file("res://Gameover/gameover.tscn")
	if (Input.is_action_just_released("Interact") && is_player_around):
		act_debt += 100;
		DepartureChanged.emit()
		pass;
	if (Input.is_action_just_released("Upgrade") && is_player_around):
		upgrade_count += 1;
	pass


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
	if (GlobalData.power < 0):
		return;
	if (hp < 500):
		hp += workspeed
		GlobalData.power -= workspeed
		if (hp > 500):
			hp == 500;
	if (hp < 0):
		return;
	GlobalData.power -= upgrade_count;
	act_debt += (1 + (0.1 * workspeed) + (0.5) * upgrade_count);
	DepartureChanged.emit()
	pass # Replace with function body.
