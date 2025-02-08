extends Node

var enemy_scene = preload("res://enemy/enemy.tscn")

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position.x = randi_range(0, 100)
	enemy.position.y = randi_range(0, 100)
	enemy.base = get_node("../Base")
	add_child(enemy)
