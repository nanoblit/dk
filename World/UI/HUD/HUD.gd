extends Node2D

export (NodePath) var player_node

func _ready():
	$HPBar.player = get_node(self.player_node)
