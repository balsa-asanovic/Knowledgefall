extends TextureButton

@onready var global = get_node("/root/Global")

@export var color: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func ChangeColor():
	global.current_color = color
