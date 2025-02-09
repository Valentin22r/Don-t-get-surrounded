extends StaticBody2D

class_name Usine

@onready var map = get_tree().get_root().get_node("Map")
@onready var drone = load("res://drone/drone_=>.tscn");

@export var timer: Timer

signal Progression

var workspeed: int = 0;
var hp: int = 100
var life: int = 100

enum RESOURCE {
	BULLETS = 0,
	DRONES = 1,
	UPGRADE = 2
}

var construction_time: int = 0;
var ongoing_construction: float = 0;
var upgrade_count: float = 1;
var _resource: RESOURCE;
var is_player_around: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_count = 0
	is_player_around = false
	add_to_group("building")
	_resource = 0;
	construction_time = 30;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("Interact") && is_player_around):
		print("switching constuction")
		_resource = (_resource + 1) % 3
		$Construction.frame = _resource
		construction_time = (_resource + 1) * 30
		Progression.emit()
	if (is_player_around && Input.is_action_just_released("Upgrade") && GlobalData.upgrade > 0):
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

func create_resource():
	if (_resource == RESOURCE.BULLETS):
		GlobalData.ammo += 200;
		return;
	if (_resource == RESOURCE.DRONES):
		var instance_drone = drone.instantiate()
		instance_drone.player = map.get_node("test_mob")
		instance_drone.position = position
		map.add_child.call_deferred(instance_drone)
		return;
	GlobalData.upgrade += 1;
func _on_timer_timeout():
	if (GlobalData.power < 0):
		return;
	if (life < 100):
		life += workspeed
		GlobalData.power -= workspeed
		if (life > 100):
			life == 100;
	if (life < 0):
		return;
	GlobalData.power -= upgrade_count;
	ongoing_construction += (1 + (0.1 * workspeed) + (0.5 * upgrade_count));
	if (construction_time != 0 && ongoing_construction >= construction_time):
		ongoing_construction -= construction_time;
		create_resource();
	Progression.emit()
	pass # Replace with function body.
