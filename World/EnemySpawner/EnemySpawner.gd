extends Node2D

var goblin = preload("res://World/Enemies/Goblin/Goblin.tscn")

func _ready() -> void:
	var chance_function = (-(1 / sqrt(Game.current_level + 1)) + 1) * 100
	
	if randi() % 101 <= chance_function: 
		spawn_enemy(goblin)

func spawn_enemy(enemy):
	var enemy_instance = enemy.instance()
	get_tree().current_scene.add_child(enemy_instance)
	enemy_instance.position.x = global_position.x
	enemy_instance.position.y = Game.current_level_y_position + global_position.y - enemy_instance.get_node("CollisionShape2D").shape.extents.y
	enemy_instance.direction = 0
	enemy_instance.get_node("Sprite").flip_h = true if randi() % 2 == 0 else false
	enemy_instance.level = Game.current_level
