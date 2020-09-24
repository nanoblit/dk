extends RichTextLabel

onready var player = get_tree().get_root().find_node("Player", true, false)

func _process(delta: float) -> void:
	if (player != null):
		text = "Coins Earned: " + str(player.coins)
