extends Node2D

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open("res://questions.json", FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()

	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		global.questions = json.data.questions
	else:
		print("Error while parsing JSON data!")

func _process(delta):
	if global.question_hit && !global.question_set:
		var question = get_node("Question")
		
		get_node("Question/Control/Answers/Option 1").modulate = Color(1, 1, 1, 1)
		get_node("Question/Control/Answers/Option 2").modulate = Color(1, 1, 1, 1)
		get_node("Question/Control/Answers/Option 3").modulate = Color(1, 1, 1, 1)
		get_node("Question/Control/Answers/Option 4").modulate = Color(1, 1, 1, 1)
		
		question.move(Vector2(0, 0))
		randomize()
		var question_id = int(randf_range(1, 100))
		get_node("Question/Control/QuestionText").text = global.questions[question_id].question
		get_node("Question/Control/Answers/Option 1").text = global.questions[question_id].possible_answers[0]
		get_node("Question/Control/Answers/Option 2").text = global.questions[question_id].possible_answers[1]
		get_node("Question/Control/Answers/Option 3").text = global.questions[question_id].possible_answers[2]
		get_node("Question/Control/Answers/Option 4").text = global.questions[question_id].possible_answers[3]
		global.current_answer = global.questions[question_id].correct_answer
		global.question_set = true
	if global.score < 0:
		var question = get_node("Question")
		question.move(Vector2(-576, 0))
		global.question_set = false
		global.current_answer = ""
		global.question_hit = false
	if global.correct_answer == true:
		var question = get_node("Question")
		question.move(Vector2(-576, 0))
		global.question_set = false
		global.current_answer = ""
		global.question_hit = false
		global.correct_answer = false

func _on_StartButton_pressed():
	get_node("UI/MenuButtons").move(Vector2(-576, 0))
	get_node("UI/DifficultyButtons").move(Vector2(0, 0))

func _on_BackButton_pressed():
	get_node("UI/MenuButtons").move(Vector2(0, 0))
	get_node("UI/DifficultyButtons").move(Vector2(576, 0))
	
func _on_HardButton_pressed():
	MoveStuff(0, -400, 576, 0, 0, 150, 0, 762, 0, 0, "Hard", 3, false)

func _on_HarderButton_pressed():
	MoveStuff(0, -400, 576, 0, 0, 150, 0, 650, 0, 0, "Harder", 6, false)

func _on_HardestButton_pressed():
	MoveStuff(0, -400, 576, 0, 0, 150, 0, 538, 0, 0, "Hardest", 9, false)
	
func _on_BackButtonDifficulty_pressed():
	get_node("UI/MenuButtons").move(Vector2(-576, 0))
	get_node("Score/EndOptions").move(Vector2(576, -40))
	MoveStuff(0, 100, 0, 0, 0, -400, 0, 1024, 576, 0, "Hard", 3, true)
	global.score = 0
	
func MoveStuff(ui_x, ui_y, db_x, db_y, score_x, score_y, buttons_x, buttons_y, em_x, em_y, mode, limit, over):
	get_node("UI").move(Vector2(ui_x, ui_y))
	get_node("UI/DifficultyButtons").move(Vector2(db_x, db_y))
	get_node("Score").move(Vector2(score_x, score_y))
	get_node("Buttons").move(Vector2(buttons_x, buttons_y))
	get_node("Emitters").begin_game()
	get_node("Emitters").move(Vector2(em_x, em_y))
	get_node("Score/HighScore").text = "High Score: " + str(global.get_high_score("HighScores", mode))
	
	global.current_mode = mode
	global.projectile_limit = limit
	
	global.game_over = over


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_RestartButton_pressed():
	get_node("Emitters").begin_game()
	get_node("Score/EndOptions").move(Vector2(576, -40))
	
	global.score = 0
	global.game_over = false

func end_options():
	get_node("Score/EndOptions").move(Vector2(0, -40))
	get_node("Emitters").move(Vector2(576, 0))



