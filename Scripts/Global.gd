extends Node2D

var testGlobal = 15

var score = 0.0
var projectile_speed = 5
var emit_time = 3#2
var emit_min = .5
var emit_delta = .005
var game_over = false
var question_frequency = 6
var question_hit = false
var questions = []
var question_set = false
var current_answer = ""
var correct_answer = false
var current_screen = "Main Menu"

var current_mode = "Hard"
var current_color = "Green"

var projectile_limit = 0

var save_file_path = "user://save-file.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_file_path)

var screen_size_x = 0
var screen_size_y = 0

var usable_rec_pos = Vector2(0, 0)
var usable_rec_size = Vector2(0, 0)

var stretch_x = 1
var stretch_y = 1

var current_background = 4

var UI_pos_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():

	var screen_size = DisplayServer.screen_get_size()
	#var screen_size = get_viewport_rect().size
	
	if OS.get_name() == "Windows":
		screen_size_x = screen_size.y
		screen_size_y = screen_size.x
	else:
		screen_size_x = screen_size.x
		screen_size_y = screen_size.y
	
	stretch_x = screen_size_x / 1080.0
	stretch_y = screen_size_y / 1920.0
	
	var usable_rec = DisplayServer.get_display_safe_area()
	var OS_name = OS.get_name()
	if OS_name == "Windows":
		usable_rec_pos = Vector2(usable_rec.position.y, usable_rec.position.x)
		usable_rec_size = Vector2(usable_rec.size.y, usable_rec.size.x)
	else:
		usable_rec_pos = usable_rec.position
		usable_rec_size = usable_rec.size

	if screen_size.y / 1920.0 > 1:
		UI_pos_y = usable_rec_pos.y + (1920.0 * ((screen_size.y / 1920.0) - 1)) / (2 if OS_name == "iOS" else 3.5)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_high_score(section, key):
	return config.get_value(section, key, 0)

func save_item(section, key, value):
	if score > config.get_value("HighScores", current_mode, 0):
		config.set_value("HighScores", current_mode, score)
		config.save(save_file_path)
		
func change_score(change):
	score += change
	if (emit_time > emit_min):
		emit_time -= emit_delta


