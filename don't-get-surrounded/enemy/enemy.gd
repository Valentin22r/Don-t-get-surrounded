extends CharacterBody2D

var speed = 200
var life = GlobalData.basic_enemy_life
var hp = -1
var death_animation_repetition = 2
var death_time = 1
var target: Array

@export var base: Node2D
@onready var nav_agent:= $NavigationAgent2D as NavigationAgent2D

func _ready() -> void:
	$Area2D.add_to_group("enemy")
	makepath()

func _on_timer_move_timeout() -> void:
	if (life <= 0 and death_time >= 0):
		death_time -= 1
		death()
	$Sprite2D.look_at(base.position)
	$Area2D.look_at(base.position)
	$CollisionShape2D.look_at(base.position)
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

func makepath() ->void:
	nav_agent.target_position = base.global_position

func _on_timer_timeout() -> void:
	if (life > 0):
		if ($Sprite2D.flip_v == true):
			$Sprite2D.flip_v = false
		else:
			$Sprite2D.flip_v = true
	else:
		add_to_group("drone")
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

func _on_timer_attack_timeout() -> void:
	if not target.is_empty():
		if is_instance_valid(target[0]):
			target[0].hp -= 1
		else:
			target.pop_front()

func _on_area_2d_body_entered(body: Node) -> void:
	if body is StaticBody2D and body.is_in_group("building"):
		target.append(body)
