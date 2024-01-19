extends Node2D
@onready var anim = get_node("AnimationPlayer")
func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	anim.play("Game Start")
	save.loadGame()







func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Game Start":
		get_tree().change_scene_to_file("res://worlds/loadingscreen/loadingscreen.tscn")
	else:
		print("Error")
	pass # Replace with function body.
