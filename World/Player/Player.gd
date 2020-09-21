extends "../Common/Walkable.gd"

export (int) var ladder_speed = 100

var on_ladder = null
var stick_to_ladder = false
var ladder_direction = 0

func _physics_process(delta):
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

func _process(delta):
	print(on_ladder)
	
	# Manage Animations
	$Sprite.playing = true
	
	match (direction):
		-1:
			$Sprite.flip_h = true
		1:
			$Sprite.flip_h = false

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
		else:
			$Sprite.animation = "jump"

func get_input():
	var new_direction = 0
	if Input.is_action_pressed("walk_right"):
		new_direction += 1
	if Input.is_action_pressed("walk_left"):
		new_direction -= 1
	
	direction = new_direction
	
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
