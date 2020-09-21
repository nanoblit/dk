extends "../../Common/Walkable.gd"

var min_distance_from_player = 20

var attacking = false

var damage = 1

onready var player = get_tree().get_root().find_node("Player", true, false)

func _ready() -> void:
	$Sprite.playing = true
	

func _process(delta: float) -> void:
	# Attack the player on the last frame of the "attack" animation (will call it every frame but that's ok because of invisibility)
	if $Sprite.animation == "attack" && $Sprite.frame == $Sprite.frames.get_frame_count("attack") - 1:
		attack_player()
	
	if !player: # Don't do anything if player's dead
		direction = 0
		attacking = false
	else:
		# Move in player's direction
		if player.global_position.x < global_position.x - min_distance_from_player: 
			direction = -1
			attacking = false
		# Move in player's direction
		elif player.global_position.x > global_position.x + min_distance_from_player:
			direction = 1
			attacking = false
		# Stop and start attacking if next to player
		else:
			direction = 0
			attacking = true
	
	if direction != 0:
		$Sprite.animation = "walk"
	elif attacking:
		$Sprite.animation = "attack"
	elif (direction == 0):
		$Sprite.animation = "idle"
	

	if direction < 0:
		$Sprite.flip_h = true
	elif direction > 0:
		$Sprite.flip_h = false

func attack_player():
	var bodies = $AttackDetector.get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			body.get_node("Health").deal_damage(damage)
