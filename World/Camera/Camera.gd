extends Node2D

func _ready():
	$Camera2D.current = true

func _process(delta: float):
	global_position.y = -(Game.current_level - 1) * Game.level_height
