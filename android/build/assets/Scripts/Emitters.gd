extends Node2D

var timer
var game_type = "Hard"
var limit = 0

@onready var global = get_node("/root/Global")

var choices = [ preload("res://Scenes/blueProjectile.tscn"), 
				preload("res://Scenes/greenProjectile.tscn"), 
				preload("res://Scenes/redProjectile.tscn"),
				preload("res://Scenes/purpleProjectile.tscn"),
				preload("res://Scenes/orangeProjectile.tscn"),
				preload("res://Scenes/yellowProjectile.tscn"),
				preload("res://Scenes/diffGreenProjectile.tscn"),
				preload("res://Scenes/diffBlueProjectile.tscn"),
				preload("res://Scenes/diffRedProjectile.tscn") ]

var emmiters = [get_node("LeftEmitter"), get_node("MiddleEmitter"), get_node("RightEmitter")]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func begin_game():
	timer = get_node("Timer")
	timer.set_wait_time(global.emit_time)
	timer.start()


func _on_timer_timeout():
	randomize()
	var projectile = choices[int(randf_range(0, global.projectile_limit))].instantiate()
	
	randomize()
	if (int(randf_range(1, global.question_frequency)) == 2):
		projectile.toggleQuestionMark()
		
	if (!global.question_hit):
		add_child(projectile)
	
	randomize()
	var emit = int(randf_range(1, 4))
	if emit == 1:
		projectile.position = get_node("LeftEmitter").position
	if emit == 2:
		projectile.position = get_node("MiddleEmitter").position
	if emit == 3:
		projectile.position = get_node("RightEmitter").position

	projectile.y_speed = int(global.projectile_speed)
	if (global.game_over == false):
		timer.set_wait_time(global.emit_time)
		timer.start()
	else:
		timer.stop()

func move(target):
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", target, 1)
