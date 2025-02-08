extends Node2D

@onready var map = get_tree().get_root().get_node("Map")
@onready var drone = load("res://drone/drone_=>.tscn");

@export var timer: Timer

var workspeed: int = 0;

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
	is_player_around = false
	add_to_group("workplace")
	_resource = RESOURCE.DRONES;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("Interact") && is_player_around):
		_resource = (_resource + 1) % 3
		construction_time = (_resource + 1) * 15
	if (Input.is_action_just_released("Interact")):
		print("Drones: ", workspeed, "\nconstruction is at ", ongoing_construction, " out of ", construction_time)
		pass;
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
	print(_resource, RESOURCE.DRONES)
	if (_resource == RESOURCE.BULLETS):
		GlobalData.ammo += 200;
		return;
	if (_resource == RESOURCE.DRONES):
		var instance_drone = drone.instantiate()
		print("Creating a drone !")
		instance_drone.player = map.get_node("test_mob")
		map.add_child.call_deferred(instance_drone)
		return;
	upgrade_count *= 0.95;

func _on_timer_timeout():
	ongoing_construction += (1 + (0.1 * workspeed));
	if (construction_time != 0 && ongoing_construction >= construction_time):
		ongoing_construction -= construction_time;
		create_resource();
	pass # Replace with function body.
