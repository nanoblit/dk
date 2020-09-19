extends Area2D

func _on_Ladder_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.enter_ladder(self)
