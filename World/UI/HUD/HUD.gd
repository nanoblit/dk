extends Node2D

export (NodePath) var player_node

func _ready():
	var player = get_node(player_node)
	player.get_child(0).connect("damage_dealt", $HPBar, "take_damage")
	player.connect("set_coins", $CoinCounter, "set_coins")
	
	
