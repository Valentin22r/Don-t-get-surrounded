extends Node

var hp = 2000
var life = -1
var cost = 2

func _ready() -> void:
	add_to_group("building")
	$Area2D.add_to_group("building")

func _process(delta: float) -> void:
	if (hp <= 0):
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.is_in_group("drone") == true):
		if (GlobalData.power >= cost and hp < 100):
			hp += 1
