extends Node2D

export (Array, NodePath) var num_list


func set_coins(count: int):
	var count_str = str(count)
	
	while (count_str.length() < 3):
		count_str = "0" + count_str
	
	for c in range(count_str.length()):
		get_node(num_list[c]).frame = int(count_str[c])
	
	#if (count_str.length() > 1):
	#	$Num1.frame = int(count_str.substr(count_str.length()-2, 1))
	#$Num2.frame = int(count_str.substr(count_str.length()-1, 1))
