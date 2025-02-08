extends MeshInstance2D

@onready var map = get_tree().get_root().get_node("Map")
@onready var bullet = preload("res://turret/bullet.tscn");

@export var weapon_damage: int
@export var weapon_reload: float
@export var timer: Timer

var is_target_shootable: bool = false;
var actual_target: Area2D = null;
var target_array: Array;

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!target_array.is_empty() && is_target_shootable):
		look_at(target_array[0].global_position);
		if(timer.paused):
			shoot()
			timer.start
	pass

func shoot():
#	var random_shoot = randf_range(-1.52, -1.68)
	var random_shoot = randf_range(-1.92, -2.08)
	var instance_bullet = bullet.instantiate()
	instance_bullet._direction = rotation + random_shoot;
	instance_bullet._origin = global_position;
	instance_bullet._rotation = (rotation + random_shoot) - 3.15;
	instance_bullet._damage = weapon_damage;
	instance_bullet._zindex = z_index + 1;
	map.add_child(instance_bullet)
	pass;

func _on_detection_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if (!area.is_in_group("enemy")):
		return;
	target_array.append(area);
	is_target_shootable = true;
	pass # Replace with function body.


func _on_detection_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if (target_array.find(area) != null):
		target_array.erase(area);
		if (target_array.is_empty()):
			is_target_shootable = false;
	pass


func _on_timer_timeout():
	timer.wait_time = weapon_reload;
	if (!is_target_shootable):
		timer.stop;
		return;
	if (GlobalData.ammo > 0):
		GlobalData.ammo -= 1;
		shoot();
	pass # Replace with function body.
