extends Node2D



func _on_area_2d_body_entered(body):
	if body.name == "slimeblue":
		body.Health -= 20
