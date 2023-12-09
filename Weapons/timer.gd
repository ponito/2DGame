extends Node2D
var ocupied
var timer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer > 0:
		await get_tree().create_timer(timer).timeout
		get_node("../../..").Ocupied = 0
	pass
