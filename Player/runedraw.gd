extends Node2D

var array = [Vector2(0, 0)]
@onready var player = get_node("../../../..")
@onready var drawinterface = get_node("CanvasLayer/Base")
# Called when the node enters the scene tree for the first time.
func _ready():
	drawinterface.position = get_global_mouse_position()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass







func _on_up_mouse_exited():
	print(array)
	drawinterface.position = get_global_mouse_position()
	array.append(drawinterface.position - drawinterface.position)
	get_node("CanvasLayer/Base/Rune2D").set_points(array)
	
	print(get_global_mouse_position())
	pass # Replace with function body.
