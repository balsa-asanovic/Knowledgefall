extends Node2D

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.score > global.get_high_score("HighScores", global.current_mode):
		global.save_item("HighScores", global.current_mode, global.score)
		
		get_node("HighScore/HighScore").text = str(int(global.score))
		
	if global.score >= 0 && global.current_screen != "High Score" && global.current_screen != "High Score Difficulty":
		get_node("Score").text = str(int(global.score))
	
	if global.score < 0:
		get_node("EndOptions").move(Vector2(0, -40))
		global.game_over = true
		global.current_screen = "Game Over"
		get_node("HighScore").visible = true
		get_node("Score").text = "END"


func move(target):
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", target, 1)
