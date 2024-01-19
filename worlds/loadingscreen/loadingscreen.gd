extends Node2D
var scene = "res://game.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	if scene != null:
		ResourceLoader.load_threaded_request(scene)
	else:
		print("Error")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))
	pass
