extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_start_pressed():
	get_node("Start").move(Vector2(-576, 0))
	get_node("Difficulty").move(Vector2(0, 0))


func _on_back_pressed():
	get_node("Start").move(Vector2(0, 0))
	get_node("Difficulty").move(Vector2(576, 0))
