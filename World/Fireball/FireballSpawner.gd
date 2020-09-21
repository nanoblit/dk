extends Node2D

export (int) var direction = -1

var distance_to_spawn = 200

var disabled = true

var last_fireball_instance = null

var fireball = preload("res://World/Fireball/Fireball.tscn")

func _process(delta: float) -> void:
	if last_fireball_instance != null && abs(last_fireball_instance.global_position.x - global_position.x) >= distance_to_spawn:
		spawn_fireball()
		

func spawn_fireball():
	var fireball_instance = fireball.instance()
	last_fireball_instance = fireball_instance
	get_tree().current_scene.add_child(fireball_instance)
	fireball_instance.global_position = global_position
	fireball_instance.direction = direction

func set_disabled(value: bool):
	disabled = value
	if value == false:
		spawn_fireball()
