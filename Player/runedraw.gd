extends Node2D


var symbolarray = []
@onready var player = get_node("../../../..")
@onready var drawinterface = get_node("Base")
@onready var drawnrune = get_node("Base/Rune2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Base").position= get_local_mouse_position()
	print(get_global_mouse_position())
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(symbolarray)
	pass


func test_if_last_self():
	pass
