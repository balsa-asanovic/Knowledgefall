extends TextureButton

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#	pass

func ArrowPressed():
	var path = "res://Scenes/" + str(global.current_color) + "Projectile.tscn"
	var projectile = load(str(path)).instantiate()
	
	var projectileCount = get_child_count()
	if projectileCount < 1:
		add_child(projectile)

	projectile.position = Vector2(68, 0)
	projectile.y_speed = -int(global.projectile_speed)


