extends Node2D

export (int) var starting_hp = 3
export (int) var gap = 20

var player
var player_ready = false
var max_hp = starting_hp
var hp = max_hp
var hp_obj = preload("res://World/UI/HUD/HP.tscn")
var hp_obj_list = [];

func _ready():
	for n in range(starting_hp):
		var hp_inst = hp_obj.instance()
		hp_inst.get_child(0).frame = 1
		hp_obj_list.push_back(hp_inst)
		call_deferred("add_child", hp_inst)
		hp_inst.position.x = n * gap
		hp_inst.index = n
	
	animate_hearts()

func _process(delta):
	if (!player_ready):
		if (player):
			player.get_child(0).connect("damage_dealt", self, "take_damage")
			player_ready = true

func add_hp(count):
	max_hp += 1
	hp += 1
	
	var hp_inst = hp_obj.instance()
	hp_obj_list.push_back(hp_inst)
	
	hp_obj_list[hp-1].get_child(0).frame = 1

func take_damage(amount):
	for n in range(amount):
		hp -= 1
		hp_obj_list[hp].get_child(0).frame = 0
		if hp == 0:
			break

func animate_hearts():
	yield (get_tree().create_timer(1), "timeout")
	hp_obj_list[0].bump()
