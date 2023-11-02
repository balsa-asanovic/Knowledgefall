extends Node2D

@onready var global = get_node("/root/Global")

var y_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var questionMarkType = randi_range(1, 2)
	get_node("QuestionMark").texture = load("res://Sprites/questionMark" + str(questionMarkType) + ".png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += y_speed
	
	if position.y > global.screen_size_y || position.y < -1500 || global.game_over || global.question_hit:
		print(position)
		print("Deleted")
		queue_free()

func _on_area_2d_area_entered(area):
	if get_node("Area2D").areaType == area.areaType:
		if ($QuestionMark.visible):
			global.question_hit = true
		global.change_score(.5)
		queue_free()
	if area.areaType == "Barrier" and y_speed > 0:
		global.change_score(-10)

func toggleQuestionMark():
	if ($QuestionMark.visible):
		$QuestionMark.hide()
	else:
		$QuestionMark.show()
