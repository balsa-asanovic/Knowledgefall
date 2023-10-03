extends Node2D

@onready var global = get_node("/root/Global")
# @onready var game = get_node("/root/Game")

var y_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += y_speed
	
	if position.y > 1024 || position.y < -1500 || global.game_over || global.question_hit:
		print(position)
		print("Deleted")
		queue_free()

func _on_area_2d_area_entered(area):
	if get_node("Area2D").areaType == area.areaType:
		if ($QuestionMark.visible):
			global.question_hit = true
			# game.show_question()
		global.change_score(.5)
		queue_free()
	if area.areaType == "Barrier" and y_speed > 0:
		global.change_score(-10)

func toggleQuestionMark():
	if ($QuestionMark.visible):
		$QuestionMark.hide()
	else:
		$QuestionMark.show()
