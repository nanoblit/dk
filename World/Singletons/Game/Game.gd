extends Node

var level0 = preload("res://Levels/Level0.tscn")
var level1 = preload("res://Levels/Level1.tscn")
var level2 = preload("res://Levels/Level2.tscn")

# -1 because at the begining we spawn 2 levels adding 2 to this number
var current_level = -1

var level_height = 176

var current_level_y_position = 0

var levels = []

func _ready():
	next_level()
	next_level()

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func next_level():
	call_deferred("next_level_deferred")

func next_level_deferred():
	# Doing this so we don't keep old levels
	if levels.size() > 1:
		delete_oldest_level()
	
	var last_level
	if (levels.size() > 0):
		last_level = levels[0]
	if !last_level:
		spawn_level(level0)
	elif last_level.tag == "Level0" || last_level.tag == "Level2":
		spawn_level(level1)
	elif last_level.tag == "Level1":
		spawn_level(level2)
	
	current_level += 1
	current_level_y_position -= level_height

func spawn_level(level: Resource):
	var level_instance = level.instance()
	get_tree().current_scene.add_child(level_instance)
	level_instance.global_position.y = current_level_y_position
	levels.push_front(level_instance)

func delete_oldest_level():
	var oldest_level = levels[levels.size() - 1]
	oldest_level.queue_free()
	levels.remove(levels.size() - 1)
