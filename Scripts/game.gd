extends Node2D

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	load_questions()

func _process(delta):
	if global.questions.size() < 3:
		load_questions()
	if global.question_hit && !global.question_set:
		var question = get_node("Question")
		
		get_node("Question/Control/Answers/Option 1").modulate = Color(1, 1, 1, 1)
		get_node("Question/Control/Answers/Option 2").modulate = Color(1, 1, 1, 1)
		get_node("Question/Control/Answers/Option 3").modulate = Color(1, 1, 1, 1)
		get_node("Question/Control/Answers/Option 4").modulate = Color(1, 1, 1, 1)
		
		question.move(Vector2(0, 0))
		randomize()
		var question_id = 110#int(randf_range(1, global.questions.size() - 1))
		
		# adjusting font size to fit button width
		var font = load("res://Fonts/Gugi-Regular.ttf")
		var font_size_1 = 64
		var font_size_2 = 64
		var font_size_3 = 64
		var font_size_4 = 64
		var font_size_5 = 50
		var font_string_size1 = font.get_string_size(global.questions[question_id].possible_answers[0], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_1)
		var font_string_size2 = font.get_string_size(global.questions[question_id].possible_answers[1], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_2)
		var font_string_size3 = font.get_string_size(global.questions[question_id].possible_answers[2], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_3)
		var font_string_size4 = font.get_string_size(global.questions[question_id].possible_answers[3], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_4)
		var font_string_size5 = font.get_string_size(global.questions[question_id].question, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_5)
		
		while(font_string_size1.x > 535 || font_string_size2.x > 535 || font_string_size3.x > 535 || font_string_size4.x > 535 || font_string_size5.x > 2000):
			if(font_string_size1.x > 535):
				font_size_1 -= 1
				font_string_size1 = font.get_string_size(global.questions[question_id].possible_answers[0], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_1)
			if(font_string_size2.x > 535):
				font_size_2 -= 1
				font_string_size2 = font.get_string_size(global.questions[question_id].possible_answers[1], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_2)
			if(font_string_size3.x > 535):
				font_size_3 -= 1
				font_string_size3 = font.get_string_size(global.questions[question_id].possible_answers[2], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_3)
			if(font_string_size4.x > 535):
				font_size_4 -= 1
				font_string_size4 = font.get_string_size(global.questions[question_id].possible_answers[3], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_4)
			if(font_string_size5.x > 2000):
				font_size_5 -= 1
				font_string_size5 = font.get_string_size(global.questions[question_id].question, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size_5)
		
		get_node("Question/Control/Answers/Option 1").add_theme_font_size_override("font_size", font_size_1)
		get_node("Question/Control/Answers/Option 2").add_theme_font_size_override("font_size", font_size_2)
		get_node("Question/Control/Answers/Option 3").add_theme_font_size_override("font_size", font_size_3)
		get_node("Question/Control/Answers/Option 4").add_theme_font_size_override("font_size", font_size_4)
		get_node("Question/Control/QuestionText").add_theme_font_size_override("font_size", font_size_5)
		
		get_node("Question/Control/QuestionText").text = global.questions[question_id].question
		get_node("Question/Control/Answers/Option 1").text = global.questions[question_id].possible_answers[0]
		get_node("Question/Control/Answers/Option 2").text = global.questions[question_id].possible_answers[1]
		get_node("Question/Control/Answers/Option 3").text = global.questions[question_id].possible_answers[2]
		get_node("Question/Control/Answers/Option 4").text = global.questions[question_id].possible_answers[3]
		global.current_answer = global.questions[question_id].correct_answer
		global.questions.remove_at(question_id)
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
	global.current_screen = "Difficulty Selection"
	get_node("UI/MenuButtons").move(Vector2(-576, 0))
	get_node("UI/DifficultyButtons").move(Vector2(0, 0))

func _on_BackButton_pressed():
	global.current_screen = "Main Menu"
	get_node("UI/MenuButtons").move(Vector2(0, 0))
	get_node("UI/DifficultyButtons").move(Vector2(576, 0))
	
func _on_HardButton_pressed():
	if global.current_screen == "High Score Difficulty":
		global.current_screen = "High Score"
		show_high_score("Hard")
	else:
		global.current_screen = "In Game"
		get_node("Score/HighScore").visible = true
		MoveStuff(0, -400, 576, 0, 0, 150, 0, 762, 0, 0, "Hard", 3, false)

func _on_HarderButton_pressed():
	if global.current_screen == "High Score Difficulty":
		global.current_screen = "High Score"
		show_high_score("Harder")
	else:
		global.current_screen = "In Game"
		get_node("Score/HighScore").visible = true
		MoveStuff(0, -400, 576, 0, 0, 150, 0, 650, 0, 0, "Harder", 6, false)

func _on_HardestButton_pressed():
	if global.current_screen == "High Score Difficulty":
		global.current_screen = "High Score"
		show_high_score("Hardest")
	else:
		global.current_screen = "In Game"
		get_node("Score/HighScore").visible = true
		MoveStuff(0, -400, 576, 0, 0, 150, 0, 538, 0, 0, "Hardest", 9, false)
	
func _on_BackButtonDifficulty_pressed():
	if global.current_screen == "Game Over":
		global.current_screen = "Difficulty Selection"
		get_node("UI/MenuButtons").move(Vector2(-576, 0))
		get_node("Score/EndOptions").move(Vector2(576, -40))
		MoveStuff(0, 100, 0, 0, 0, -400, 0, 1024, 576, 0, "Hard", 3, true)
		global.score = 0
	elif global.current_screen == "High Score":
		get_node("UI").move(Vector2(0, 0))
		get_node("Score").move(Vector2(0, -400))
		global.current_screen = "High Score Difficulty"
		
	
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

func _on_high_score_button_pressed():
	global.current_screen = "High Score Difficulty"
	get_node("UI/MenuButtons").move(Vector2(-576, 0))
	get_node("UI/DifficultyButtons").move(Vector2(0, 0))

func show_high_score(difficulty):
	var high_score = global.get_high_score("HighScores", difficulty)
	get_node("Score/Score").text = str(high_score)
	get_node("Score/HighScore").visible = false
	get_node("UI").move(Vector2(0, 1024))
	get_node("Score").move(Vector2(0, 150))

func load_questions():
	var file = FileAccess.open("res://questions.json", FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()

	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		global.questions = json.data.questions
	else:
		print("Error while parsing JSON data!")
