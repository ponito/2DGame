extends ProgressBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = get_node("../../..").Health
	max_value = master.maxplayerHealth
	print(get_node("../../..").Health)
	print(master.maxplayerHealth)
	pass
