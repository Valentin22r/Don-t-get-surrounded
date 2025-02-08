extends TextureProgressBar

@export var ship: Ship

# Called when the node enters the scene tree for the first time.
func _ready():
	ship.DepartureChanged.connect(update)
	update() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = ship.ship_departure / 1800;
