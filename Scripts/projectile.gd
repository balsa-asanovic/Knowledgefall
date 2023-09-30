extends Node2D

@onready var global = Global

var y_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += y_speed


func _on_projectile_area_area_entered(area):
	# we check the color of the area with which this area collided
	if get_node("ProjectileArea").areaType == area.areaType:
		# if colors match delete both areas
		queue_free()
