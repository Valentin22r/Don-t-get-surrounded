extends Node

@export var rand_x: int
@export var rand_y: int
var nb : int

var enemy_scene = preload("res://enemy/enemy.tscn")

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.add_to_group("enemy")
	enemy.position.x = randi_range(rand_x, rand_x + 100)
	enemy.position.y = randi_range(rand_y, rand_y + 100)
	enemy.base = get_node("../Base")
	add_child(enemy)
	nb += 1
	if (nb == 10):
		$Timer.wait_time -= 0.05
		nb = 0
