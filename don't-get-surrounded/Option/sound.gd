extends Node2D

var master_bus = AudioServer.get_bus_index("Master")

func _ready() -> void:
	$sound_level.text = str(GlobalData.sound + 30)
	$HSlider.set_value_no_signal(GlobalData.sound)

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, value)
	$sound_level.text = str(value + 30)
	GlobalData.sound = value
	
	if (value == -30):
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
