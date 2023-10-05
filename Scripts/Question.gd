extends Node2D

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(target):
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", target, 0.7)


func answerOne():
	var button = get_node("Control/Answers/Option 1")
	checkAnswer(button)

func answerTwo():
	var button = get_node("Control/Answers/Option 2")
	checkAnswer(button)

func answerThree():
	var button = get_node("Control/Answers/Option 3")
	checkAnswer(button)

func answerFour():
	var button = get_node("Control/Answers/Option 4")
	checkAnswer(button)

func checkAnswer(button):
	var answer = button.get_text()
	
	if (answer == global.current_answer):
		button.modulate = Color(0, 1, 0)
	else:
		button.modulate = Color(1, 0, 0)
		if (get_node("Control/Answers/Option 1").get_text() == global.current_answer):
			get_node("Control/Answers/Option 1").modulate = Color(0, 1, 0)
		elif (get_node("Control/Answers/Option 2").get_text() == global.current_answer):
			get_node("Control/Answers/Option 2").modulate = Color(0, 1, 0)
		elif (get_node("Control/Answers/Option 3").get_text() == global.current_answer):
			get_node("Control/Answers/Option 3").modulate = Color(0, 1, 0)
		elif (get_node("Control/Answers/Option 3").get_text() == global.current_answer):
			get_node("Control/Answers/Option 3").modulate = Color(0, 1, 0)
		
		global.score = -1
