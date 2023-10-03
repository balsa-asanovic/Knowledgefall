extends Node2D

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.score > global.get_high_score("HighScores", global.current_mode):
		global.save_item("HighScores", global.current_mode, global.score)
		
		get_node("HighScore").text = "High Score: " + str(int(global.score))
		
	if global.score >= 0:
		get_node("Score").text = str(int(global.score))
	
	if global.score < 0:
		get_node("EndOptions").move(Vector2(0, -40))
		global.game_over = true
		get_node("Score").text = "END"


func move(target):
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", target, 1)
