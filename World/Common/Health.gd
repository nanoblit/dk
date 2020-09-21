extends Node

export (int) var hp = 3
export (int) var max_hp = 3

onready var sprite = get_node("../Sprite")

func _process(delta: float) -> void:
	if $Timer.time_left > 0:
		sprite.visible = int($Timer.time_left * 10) % 2 == 0
	else:
		sprite.visible = true

func deal_damage(dmg: int):
	if $Timer.time_left == 0:
		hp -= dmg
		if hp <= 0:
			kill()
		$Timer.start()

func kill():
	get_parent().queue_free()
