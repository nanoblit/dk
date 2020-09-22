extends "../../Common/Walkable.gd"

var min_distance_from_player = 20
var max_distance_from_player = 150

# to detect if player is on the same level so they don't follow players on different levels
var level = 0

var attacking = false

var damage = 1

var disabled = false

onready var player = get_tree().get_root().find_node("Player", true, false)

func _ready() -> void:
	$Sprite.playing = true
	

func _process(delta: float) -> void:
	if disabled:
		direction = 0
		return
	if !is_on_floor():
		$Sprite.animation = "idle"
		jumping = false
		return
	# Attack the player on the last frame of the "attack" animation (will call it every frame but that's ok because of invisibility)
	if $Sprite.animation == "attack" && $Sprite.frame == $Sprite.frames.get_frame_count("attack") - 1:
		attack_player()
	
	# Stay idle if player's dead
	if !player || player.disabled: 
		direction = 0
		attacking = false
	else:
		# Stay idle if player is too far
		if Game.current_level - 1 != level || abs(player.global_position.x - global_position.x) > max_distance_from_player:
			direction = 0
			attacking = false
		# Move in player's direction
		elif player.global_position.x < global_position.x - min_distance_from_player: 
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
	
func push(dir: int):
	jumping = true
	velocity.y = jump_speed
	position.y -= 1
	direction = dir
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
