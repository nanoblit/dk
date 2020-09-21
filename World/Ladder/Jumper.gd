extends Area2D

func _on_Jumper_body_entered(body: Node) -> void:
	if body.name == "Player" && body.on_ladder != null:
		body.on_ladder = null
		body.jumping = true
		body.on_ladder = false
		body.velocity.y = -350
		
		Game.next_level()
