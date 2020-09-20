extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Jumper_body_entered(body: Node) -> void:
	if body.name == "Player" && body.on_ladder:
		body.jumping = true
		body.on_ladder = false
		body.jumped_off_ladder = true
		body.velocity.y = -350
		
		Game.next_level()
