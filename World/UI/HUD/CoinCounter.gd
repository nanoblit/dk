extends Node2D

func set_coins(count: int):
	var count_str = str(count)
	if (count_str.length() > 1):
		$Num1.frame = int(count_str.substr(count_str.length()-2, 1))
	$Num2.frame = int(count_str.substr(count_str.length()-1, 1))
