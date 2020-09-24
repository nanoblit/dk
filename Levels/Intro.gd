extends Node2D

onready var logo = $Logo
onready var intro = $Intro
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


func _on_Intro_animation_finished() -> void:
	get_tree().change_scene("res://Levels/World.tscn")
