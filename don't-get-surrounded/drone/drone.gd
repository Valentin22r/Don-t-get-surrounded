extends CharacterBody2D

@export var speed = 25
@export var life = 30

enum DroneState {
	FOLLOWING = 2,
	AWAITING = 1,
	SLEEPING = 0
}

var is_player_around: bool

@export var player: CharacterBody2D
@onready var nav_agent:= $NavigationAgent2D as NavigationAgent2D

var State: DroneState = DroneState.SLEEPING

func _ready():
	is_player_around = false
	add_to_group("drone")

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	if (State == DroneState.FOLLOWING):
		$Sprite.frame = 2
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
	if (is_player_around && Input.is_action_just_released("Interact")):
		if (State == DroneState.AWAITING):
			State = DroneState.SLEEPING;
			$Sprite.frame = 0;
		else:
			State = DroneState.AWAITING;
			$Sprite.frame = 1;
	if (Input.is_action_just_released("call_drones")):
		$Sprite.look_at(player.global_position);
		makepath();
		if (State == DroneState.AWAITING):
			State = DroneState.FOLLOWING
			$Sprite.frame = 2;
		
	if (Input.is_action_just_pressed("stop_drones")):
		State = DroneState.SLEEPING
		$Sprite.frame = 0;
	pass;

func _on_area_2d_body_entered(body):
	if(body.is_in_group("player")):
		is_player_around = true;

func _on_area_2d_body_exited(body):
	if(body.is_in_group("player")):
		is_player_around = false;
