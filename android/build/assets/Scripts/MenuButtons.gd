extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "iOS":
		get_node("QuitButton").hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move(target):
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", target, 1)
