extends Node2D
var collisionx
var anim_name = null
@onready var player = get_node("../../../player/player")
@onready var holdpos = get_node("StaticBody2D")
@onready var anim = get_node("../../../player/player/AnimationPlayer")
func  _process(_delta):
	if collisionx == true:
		# Handle Fallthrough Platforms fallthrough.
		if Input.is_action_just_pressed("S"):
			player.position.y += 1


		if Input.is_action_pressed("W") and player.Stamina >= 1 and player.Ocupied == 0:
			if player.shoulder._overlapping.has(holdpos):
				player.velocity.x = 0
				player.velocity.y = 0
				anim.play("fallthroughclutch")
				player.position.y = -60 + position.y
				player.Stamina -= 2.2
				player.Ocupied = 1
				



func _on_area_2d_body_entered(body):
	if body == player:
		collisionx = true


func _on_area_2d_body_exited(body):
		if body == player:
			collisionx = false
