extends Node2D

var darkknife = preload("res://Weapons/projectiles/Darkknife.tscn")
var currentSpell = null
@onready var player = get_node("../..")
@onready var game = player.get_node("../..")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func spelltest(casttime, Ocupied, Fokus, Stamina, tsymbolarray):
	var spell = []
	var symbolarray = tsymbolarray
	var CastMeterMax = 0
	spell = ["DownLeft", "LeftUp", "Right","DownLeft"]
	if spell.hash() == symbolarray.hash():
		if casttime >= 0 && Ocupied <= 0 && Fokus > 0:
			currentSpell = "darkknife"
			CastMeterMax = 3
	if currentSpell != null:
		player.get_node("activeCastMeter/wait").queue_free()
		player.get_node("activeCastMeter/bar").visible = true
		player.get_node("activeCastMeter/bar").max_value = CastMeterMax
	pass



func spellbook(casttime, Ocupied, Fokus, Stamina):
	if currentSpell != null and currentSpell == "darkknife":
		if casttime >= 3 && Ocupied <= 0 && Stamina >= 2 && Fokus >= 2:
			var activeSpell
			activeSpell = darkknife.instantiate()
			activeSpell.name = "activeDarkKnife"
			activeSpell.position = player.position 
			activeSpell.position.y -= 20
			player.Fokus -= 2
			player.Stamina -= 2
			game.add_child(activeSpell)
	currentSpell = null
