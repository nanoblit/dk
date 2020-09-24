extends Node

export (int) var hp = 3
export (int) var max_hp = 3

onready var sprite = get_node("../Sprite")

signal damage_dealt(amount)

func _process(delta: float) -> void:
	if !get_parent().disabled && $Timer.time_left > 0:
		sprite.visible = int($Timer.time_left * 10) % 2 == 0
	else:
		sprite.visible = true

func deal_damage(dmg: int, push_direction: int = 0):
	if !get_parent().disabled && $Timer.time_left == 0:
		emit_signal("damage_dealt", dmg)
		hp -= dmg
		if push_direction != 0:
			get_parent().push(push_direction)
		if hp <= 0:
			kill()
		$Timer.start()

func kill():
	var sprite = get_node("../Sprite")
	sprite.animation = "death"
	get_parent().kill()
