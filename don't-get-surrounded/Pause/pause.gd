extends Control


func _on_continue_button_pressed() -> void:
	hide()
	Engine.time_scale = 1

func _on_back_button_pressed() -> void:
	Engine.time_scale = 1
	$click_buttons.play()
	await get_tree().create_timer(0.25).timeout
	hide()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
