extends Control


func _on_play_button_pressed() -> void:
	$click_buttons.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://Map/map.tscn")


func _on_option_button_pressed() -> void:
	$click_buttons.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://Option/option.tscn")


func _on_quit_button_pressed() -> void:
	$click_buttons.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()
