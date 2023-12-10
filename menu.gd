extends Node2D
@onready var anim = get_node("AnimationPlayer")
func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	anim.play("Game Start")
	save.loadGame()
	await get_tree().create_timer(1.05).timeout
	get_tree().change_scene_to_file("res://game.tscn")
	
	



