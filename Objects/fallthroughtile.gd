extends Node2D
var collisionx

@onready var player = get_node("../player/player")
@onready var holdpos = get_node("StaticBody2D")

func  _process(delta):
	
	
	if collisionx == true:
		# Handle Fallthrough Platforms fallthrough.
		if Input.is_action_just_pressed("S"):
			player.position.y += 1


		if Input.is_action_pressed("W") and player.Stamina >= 0:
			print(player.shoulder._overlapping)
			if player.shoulder._overlapping.has(holdpos):
				player.position.y -= 60
				player.Stamina -= 2.2
				player.velocity.x = 0
				player.velocity.y = 0
				




func _on_area_2d_body_entered(body):
	if body == player:
		collisionx = true


func _on_area_2d_body_exited(body):
		if body == player:
			collisionx = false
