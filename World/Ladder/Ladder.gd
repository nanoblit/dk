extends Area2D

func _on_Ladder_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		body.on_ladder = self


func _on_Ladder_body_exited(body):
	if (body.name == "Player"):
		body.on_ladder = null
		body.stick_to_ladder = false
