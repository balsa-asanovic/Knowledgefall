extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move(target):
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", target, 1)
