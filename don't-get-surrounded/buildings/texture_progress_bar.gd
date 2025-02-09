extends TextureProgressBar

@export var ship: Ship

# Called when the node enters the scene tree for the first time.
func _ready():
	ship.DepartureChanged.connect(update)
	update() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = (int)((ship.act_debt * 100) / 1800);
	if (value >= 100):
		get_tree().change_scene_to_file("res://Win/Win.tscn")
