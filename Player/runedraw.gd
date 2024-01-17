extends Node2D
var debug = null

var linearray = []
var symbolarray = []


var spelldraworigin = preload("res://Player/runedraworigin.tscn")
@onready var player = get_node("../../../..")
@onready var drawinterface = get_node("Base")
@onready var drawnrune = get_node("Base/Rune2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Base").position= get_local_mouse_position()
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.



func test_if_last_self(testsymbol):
	var counter = symbolarray.size()
	for symbol in symbolarray:
		counter = counter -1
		if counter == 0:
			if testsymbol == symbol:
				return true
			else:
				return false
		elif counter < 0:
			print("Error")
	if symbolarray.size() == 0:
		return false






func _mouse_entered(Name, Place):
	#Test if current drawpart is already the last and if not, adds it to the array
	if test_if_last_self(Name) == false and Name != "Mid":
		symbolarray.append(Name)
		
		#Adds Coordinats of Points to Line Array, and makes that the Points of the Rune V
		if linearray.size() == 0:
			var originmarker = spelldraworigin.instantiate()
			originmarker.name = "spelldraworigin"
			originmarker.position = Place
			drawinterface.add_child(originmarker)
		linearray.append(Place)
		drawnrune.points = linearray
		
		pass
	pass # Replace with function body.

func _controll_line():
	drawnrune.points = linearray
	pass
	
func _process(_delta):
	pass
