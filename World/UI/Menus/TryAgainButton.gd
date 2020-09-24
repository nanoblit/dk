extends Button

func _on_TryAgainButton_pressed() -> void:
	get_tree().reload_current_scene()
