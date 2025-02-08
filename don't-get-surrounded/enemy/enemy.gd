extends CharacterBody2D

var speed = 35
var life = GlobalData.basic_enemy_life
var death_animation_repetition = 2
var death_time = 1

@export var base: Node2D
@onready var nav_agent:= $NavigationAgent2D as NavigationAgent2D

func _ready() -> void:
	makepath()

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_left"):
		life = 0
	if (life <= 0 and death_time >= 0):
		death_time -= 1
		death()

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

func makepath() ->void:
	nav_agent.target_position = base.global_position

func _on_timer_timeout() -> void:
	if (life > 0):
		if (velocity.x <= 0):
			$Sprite2D.flip_h = true
		if (velocity.x > 0):
			$Sprite2D.flip_h = false
		if (life > 0):
			print($Sprite2D.frame)
			if ($Sprite2D.frame >= 5):
				$Sprite2D.frame = 0
			$Sprite2D.frame += 1
		makepath()

func death() -> void:
	$TimerDeath.start()
	$Sprite2D.visible = false
	$Death.visible = true

func _on_timer_death_timeout() -> void:
	if ($Death.frame == 3):
		if (death_animation_repetition <= 0):
			queue_free()
		death_animation_repetition -= 1
		$Death.frame = 0
	$Death.frame += 1
