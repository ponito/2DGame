extends Label





func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Death":
		get_node("../../../").queue_free()
		get_tree().change_scene_to_file("res://menu.tscn")

