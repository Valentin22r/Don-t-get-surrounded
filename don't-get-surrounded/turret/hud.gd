extends Node2D

func _process(delta: float) -> void:
	$amelioration_nb.text = str(GlobalData.upgrade)
	$ammo_nb.text = str(GlobalData.ammo)
	$power_nb.text = str(GlobalData.power)
