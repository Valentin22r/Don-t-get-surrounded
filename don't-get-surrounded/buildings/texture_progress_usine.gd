extends TextureProgressBar

@export var usine: Usine

# Called when the node enters the scene tree for the first time.
func _ready():
	usine.Progression.connect(update)
	update() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = (int)((usine.ongoing_construction * 100) / usine.construction_time);
