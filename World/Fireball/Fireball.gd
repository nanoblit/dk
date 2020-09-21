extends Area2D

var direction = -1

var destroyed = false

func _ready() -> void:
	$AnimatedSprite.playing = true

func _process(delta: float) -> void:
	if global_position.x < -50 || global_position.x > get_viewport().size.x + 50:
		queue_free()
		
	if direction == -1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

func _physics_process(delta: float) -> void:
	global_position.x += direction * Game.fireball_speed * delta

func _on_Fireball_body_entered(body: Node) -> void:
	if !destroyed && body.name == "Player":
		# body.jumping = true
		# body.velocity.y = -350
		body.get_node("Health").deal_damage(1)
		$AnimatedSprite.visible = false
		destroyed = true
