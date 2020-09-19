extends "../Common/Walkable.gd"

export (int) var ladder_speed = 100

var on_ladder = false
var ladder_direction = 0
var jumped_off_ladder = false

func _physics_process(delta):
	if (is_on_floor()):
		jumped_off_ladder = false
	if (on_ladder):
		moving = false
		get_ladder_input()
		do_ladder_movement(delta)
	else:
		moving = true
		get_input()

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
		on_ladder = false
		jumped_off_ladder = true

func do_ladder_movement(delta):
	velocity.x = 0
	velocity.y = ladder_direction * ladder_speed
	velocity = move_and_slide(velocity, Vector2.UP)
	if (get_slide_count() > 0):
		on_ladder = false
	if (jumping):
		velocity.y = jump_speed

func enter_ladder(ladder: Node2D):
	if (!is_on_floor() && !jumped_off_ladder) || on_ladder == true:
		on_ladder = true
		global_position.x = ladder.global_position.x
