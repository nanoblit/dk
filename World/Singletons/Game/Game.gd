extends Node

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	# last scene is the loaded scene
	current_scene = root.get_child(root.get_child_count() - 1)

func next_level():
	call_deferred("_deferred_next_level")

func _deferred_next_level():
	
	current_scene.free()
	var s = ResourceLoader.load("res://Levels/Level1.tscn")
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
