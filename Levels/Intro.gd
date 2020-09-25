extends Node2D

export (Array, int) var timer_setup

onready var logo = $Logo
onready var intro = $IntroWalk
onready var timer = $Timer

func _ready() -> void:
	logo.visible = true
	intro.visible = false

func _input(event):
	if event is InputEventKey and event.pressed:
		get_tree().change_scene("res://Levels/World.tscn")

func _on_Timer_timeout() -> void:
	logo.visible = false
	intro.visible = true
	intro.frame = 0
	intro.playing = true

func _on_IntroWalk_animation_finished():
	$IntroWalk.visible = false
	$IntroTalk.visible = true
	for i in range(len(timer_setup)):
		yield (get_tree().create_timer(timer_setup[i] / 4.0), "timeout")
		$IntroTalk.frame += 1
		if i == len(timer_setup)-1:
			get_tree().change_scene("res://Levels/World.tscn")
