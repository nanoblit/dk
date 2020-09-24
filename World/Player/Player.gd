extends "../Common/Walkable.gd"

export (int) var ladder_speed = 100

var on_ladder = null
var stick_to_ladder = false
var doing_trick = false;
var ladder_direction = 0
var disabled = false
var attacking = false

var coins = 0
var accumulated_coins = 0

func _physics_process(delta):
	if disabled:
		direction = 0
		return
	if (on_ladder != null && Input.is_action_pressed("walk_up_ladder") && !stick_to_ladder):
		position.x = on_ladder.position.x
		stick_to_ladder = true
	if (on_ladder != null && stick_to_ladder):
		moving = false
		get_ladder_input()
		do_ladder_movement(delta)
	else:
		moving = true
		get_input()
	
	if doing_trick:
		for body in $TrickDetector.get_overlapping_areas():
			if body.name.find("Fireball") >= 0 && body.tricked == false:
				body.tricked = true
				add_coins(2)

func _process(delta):
	if disabled:
		return
	if global_position.y > 240 + (Game.current_level - 2) * -Game.level_height:
		$Health.kill()
	# Manage Animations
	$Sprite.playing = true
	
	match (direction):
		-1:
			$Sprite.flip_h = true
			$AttackChecker/CollisionShape2D.position.x = -abs($AttackChecker/CollisionShape2D.position.x)
		1:
			$Sprite.flip_h = false
			$AttackChecker/CollisionShape2D.position.x = abs($AttackChecker/CollisionShape2D.position.x)

	if !attacking:
		if (is_on_floor()):
			if (velocity.x == 0):
				$Sprite.animation = "idle"
			else:
				$Sprite.animation = "walk"
		else:
			if (on_ladder != null && stick_to_ladder):
				$Sprite.animation = "climb"
				if (ladder_direction == 0):
					$Sprite.playing = false
			elif doing_trick:
				$Sprite.animation = "trick"
			else:
				$Sprite.animation = "jump"

func get_input():
	var new_direction = 0
	if Input.is_action_pressed("walk_right"):
		new_direction += 1
	if Input.is_action_pressed("walk_left"):
		new_direction -= 1
	
	direction = new_direction
	
	if Input.is_action_just_pressed("attack") && attacking == false:
		$Sprite.animation = "attack"
		attacking = true
		for body in $AttackChecker.get_overlapping_bodies():
			body.get_node("Health").deal_damage(1, sign(body.global_position.x - global_position.x))
	
	if $Sprite.frame == $Sprite.frames.get_frame_count("attack") - 1:
		attacking = false
	
	if !is_on_floor() && $Sprite.animation != "attack" && Input.is_action_just_pressed("jump"):
		doing_trick = true
	if is_on_floor():
		doing_trick = false
		
	if Input.is_action_just_pressed("jump"):
		jumping = true
	else:
		jumping = false
	

func get_ladder_input():
	var new_ladder_direction = 0
	if Input.is_action_pressed("walk_up_ladder"):
		new_ladder_direction = -1
	if Input.is_action_pressed("walk_down_ladder"):
		new_ladder_direction = 1
	
	ladder_direction = new_ladder_direction
	
	if Input.is_action_just_pressed("jump"):
		jumping = true
		on_ladder = null

func do_ladder_movement(delta):
	velocity.x = 0
	velocity.y = ladder_direction * ladder_speed
	velocity = move_and_slide(velocity, Vector2.UP)
	if (get_slide_count() > 0):
		on_ladder = null
	if (jumping):
		velocity.y = jump_speed

func add_coins(val):
	coins += val
	accumulated_coins += val
	print("Coins: ", coins)

func remove_coins(val) -> bool:
	if coins < val:
		return false
	coins -= val
	print("Coins: ", coins)
	return true
	
func kill():
	Game.deathPanel.visible = true
	if coins > Game.best_score:
		Game.best_score = coins
	disabled = true
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
