extends Node2D

var array = []
var debug = null
@onready var player = get_node("../../../..")
@onready var drawinterface = get_node("CanvasLayer/Base")
@onready var drawnrune = get_node("CanvasLayer/Rune2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	drawinterface.position = get_global_mouse_position()
	array.append(drawinterface.position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass







func _on_up_mouse_exited():
	debug = get_global_mouse_position()
	drawinterface.position = debug
	array.append(drawinterface.position)
	drawnrune.set_points(array)
	pass # Replace with function body.
