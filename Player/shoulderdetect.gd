extends Area2D
var _overlapping = []


func _on_body_entered(body):
	_overlapping.append(body)
	print(body)


func _on_body_exited(body):
	_overlapping.erase(body)


