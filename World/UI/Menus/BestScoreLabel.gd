extends RichTextLabel


func _process(delta: float) -> void:
	text = "Best Score: " + str(Game.best_score)
