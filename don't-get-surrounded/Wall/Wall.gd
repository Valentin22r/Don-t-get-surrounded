extends Node

var hp = 100
var life = -1
var cost = 2

func _ready() -> void:
	$Area2D.add_to_group("building")

func _process(delta: float) -> void:
	if (hp <= 0):
		queue_free()
	$RichTextLabel.text = str(hp)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.is_in_group("drone") == true):
		if (GlobalData.power >= cost and hp < 100):
			hp += 1
