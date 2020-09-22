extends Node2D

var index

func bump():
	position.y += 2
	yield (get_tree().create_timer(0.3), "timeout")
	position.y -= 2
	if (get_parent().get_child_count() >= index+2):
		get_parent().get_child(index+1).bump()
	else:
		yield (get_tree().create_timer(1), "timeout")
		get_parent().get_child(0).bump()
