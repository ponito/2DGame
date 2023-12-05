extends Node2D

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	save.loadGame()
	get_tree().change_scene_to_file("res://game.tscn")
	



