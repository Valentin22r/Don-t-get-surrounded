extends CharacterBody2D

var speed = 25
var life = 30

enum DroneState {
	FOLLOWING,
	WORKING,
	SLEEPING
}

@export var player: CharacterBody2D
@onready var nav_agent:= $NavigationAgent2D as NavigationAgent2D

var State: DroneState = DroneState.WORKING

func _ready():
	makepath();
	add_to_group("drone")

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	if (State == DroneState.FOLLOWING):
		move_and_slide()

func makepath() ->void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	if (velocity.x <= 0):
		$Sprite2D.flip_h = true
	if (velocity.x > 0):
		$Sprite2D.flip_h = false
	if (life > 0):
		if ($Sprite2D.frame >= 5):
			$Sprite2D.frame = 0
		$Sprite2D.frame += 1
	makepath()

func _process(delta):
	if (Input.is_action_pressed("call_drones")):
		makepath();
		State = DroneState.FOLLOWING
	if (Input.is_action_just_pressed("stop_drones")):
		State = DroneState.SLEEPING
	pass;

func working(delta):
	pass;

func sleeping():
	pass;
