extends Node2D



func _on_area_2d_body_entered(body):
	body.Health -= 20
