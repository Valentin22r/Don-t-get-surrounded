extends Area2D

var is_player_around: bool
var is_player_talking: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	is_player_around = false
	is_player_talking = false
	add_to_group("drone")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_player_around && Input.is_action_just_released("Interact")):
		if (is_player_talking):
			is_player_talking = GlobalData.is_in_tutorial
		else:
			is_player_talking = true
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/tutorial.dialogue"), "start")
	pass

func _on_body_entered(body):
	if (body.is_in_group("player")):
		is_player_around = true
	pass # Replace with function body.


func _on_body_exited(body):
	if (body.is_in_group("player")):
		is_player_around = false;
	pass # Replace with function body.
