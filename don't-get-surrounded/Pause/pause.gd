extends Control


func _on_back_button_pressed() -> void:
	$click_buttons.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
