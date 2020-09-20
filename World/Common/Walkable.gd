extends KinematicBody2D

# Requires an Area2D called CornerChecker with a CollisionShape2D. The origin has to be in the center of the character.

export (int) var speed = 150
export (int) var jump_speed = -350
export (int) var gravity = 1000
export (int) var max_step_difference = 5;

var direction: int = 0
var jumping: bool = false
var moving: bool = true

var velocity = Vector2.ZERO

onready var corner_checker = $CornerChecker

func _ready():
	set_area_shape_to_our_shape()

func _physics_process(delta):
	if !moving:
		return
	velocity.x = direction * speed
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var floor_collision_shape: CollisionShape2D = collision.collider.get_node("CollisionShape2D")
		var floor_rectangle: RectangleShape2D = floor_collision_shape.shape
		
		var feet_position = global_position.y + $CollisionShape2D.shape.extents.y
		var floor_position = floor_collision_shape.global_position.y - floor_rectangle.extents.y
		var feet_to_floor_difference = feet_position - floor_position
		
		if feet_position > floor_position && feet_to_floor_difference <= max_step_difference:
			var new_position = Vector2(position.x + speed * delta * direction, position.y - feet_to_floor_difference - 1)
			move_if_place_is_free(new_position)
		
	if jumping && is_on_floor():
		velocity.y = jump_speed

func set_area_shape_to_our_shape():
	var areasCollisionShape: CollisionShape2D = corner_checker.get_node("CollisionShape2D")
	areasCollisionShape.shape = $CollisionShape2D.shape

func move_if_place_is_free(new_position: Vector2):
	corner_checker.global_position = new_position
	
	var can_move = true
	
	for body in corner_checker.get_overlapping_bodies():
		if (body.name != name):
			can_move = false
			break
	
	if can_move:
		position = new_position
