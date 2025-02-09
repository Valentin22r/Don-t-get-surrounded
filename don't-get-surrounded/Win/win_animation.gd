extends Sprite2D

func _process(delta: float) -> void:
	position.y -= 2
	if (position.y <= -4750):
		get_tree().change_scene_to_file("res://Win/win_menu.tscn")
