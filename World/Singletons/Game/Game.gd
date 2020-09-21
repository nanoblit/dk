extends Node

var level0 = preload("res://Levels/Level0.tscn")
var level1 = preload("res://Levels/Level1.tscn")
var level2 = preload("res://Levels/Level2.tscn")

# -1 because at the begining we spawn 2 levels adding 2 to this number
var current_level = -1

var level_height = 176

# because it substracts level_height before spawning a level
var current_level_y_position = level_height

var levels = []

var min_fireball_speed = 20
var fireball_speed = min_fireball_speed
var fireball_speed_increase = 5

func _ready():
	randomize()
	next_level()
	next_level()

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	fireball_speed += fireball_speed_increase * delta

func next_level():
	call_deferred("next_level_deferred")

func next_level_deferred():
	# Doing this so we don't keep old levels
	if levels.size() > 1:
		delete_oldest_level()
	
	current_level += 1
	current_level_y_position -= level_height
	fireball_speed = min_fireball_speed
	
	var last_level
	if (levels.size() > 0):
		last_level = levels[0]
	if !last_level:
		spawn_level(level0)
	elif last_level.tag == "Level0" || last_level.tag == "Level2":
		spawn_level(level1)
	elif last_level.tag == "Level1":
		spawn_level(level2)
	
	# Spawn fireballs on the lowest visible level
	levels[0].get_node("FireballSpawner").set_disabled(true)
	if levels.size() > 1:
		levels[1].get_node("FireballSpawner").set_disabled(false)


func spawn_level(level: Resource):
	var level_instance = level.instance()
	get_tree().current_scene.add_child(level_instance)
	level_instance.global_position.y = current_level_y_position
	levels.push_front(level_instance)

func delete_oldest_level():
	var oldest_level = levels[levels.size() - 1]
	oldest_level.queue_free()
	levels.remove(levels.size() - 1)
