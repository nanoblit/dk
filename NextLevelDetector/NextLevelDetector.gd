extends Area2D

func _on_NextLevelDetector_body_entered(body: Node) -> void:
	if body.name == "Player":
		var Game = get_node("/root/Game")
		Game.next_level()
