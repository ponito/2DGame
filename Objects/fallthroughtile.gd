extends Node2D
var collisionx = false

@onready var player = get_node("../../player/player")

func  _process(delta):
	# Handle Fallthrough Platforms fallthrough.
	if Input.is_action_just_pressed("S") && collisionx == true:
		player.position.y += 1
		pass





func _on_area_2d_body_entered(body):

	if body == player:
		collisionx = true


func _on_area_2d_body_exited(body):
		if body == player:
			collisionx = false
