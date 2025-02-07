extends CharacterBody2D

var speed = 30
var life = 10

@export var base: Node2D
@onready var nav_agent:= $NavigationAgent2D as NavigationAgent2D

func _ready() -> void:
	makepath()

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_left"):
		death()

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	
func makepath() ->void:
	nav_agent.target_position = base.global_position

func _on_timer_timeout() -> void:
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
	$Sprite2D.hide()
	$Death.show()
	if ($Death.frame == 3):
		queue_free()
	pass

func _on_timer_death_timeout() -> void:
	$Death.frame += 1
