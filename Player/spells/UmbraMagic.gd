extends Node2D

var darkknife = preload("res://Weapons/projectiles/Darkknife.tscn")
var castmeter = preload("res://Player/castmeter.tscn")
var runedraw = preload("res://Player/runedraw.tscn")
var activeSpell = null
var activeCastMeter = null
var activeRuneDraw = null
var anim_name = null
var Knockback = 1
var castposition 
var casttime = null
var neededcasttime = 0
var is_casting = false
var mousepos

var symbolarray = []

@onready var game = get_node("../../../../..")
@onready var player = get_node("../../..")
@onready var anim = get_node("../../../AnimationPlayer")
@onready var handconnect = get_node("../../Skeleton2D/hip/spine/armleft1/armleft2/armleft3/handleft/RemoteTransform2D")


func _ready():
	#connected die Waffe per Code, falls die Waffe gewechselt wird
	anim.animation_finished.connect(_on_animation_player_animation_finished)
	handconnect.remote_path = "../../../../../../../../armleft/UmbralMagic"
	
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#
	
	if Input.is_action_just_pressed("left_click") && player.Stamina >= 0 && player.Fokus > 0 && casttime == null && player.Ocupied != 1:
		if not player.get_node("activeCastMeter"):
			is_casting = true
			activeCastMeter = castmeter.instantiate()
			activeCastMeter.name = "activeCastMeter"
			activeCastMeter.position.y -= 25
			player.add_child(activeCastMeter)
			casttime = 0
		_open_spelldraw()
	
	if Input.is_action_just_pressed("right_click"):
		if player.get_node("activeRuneDraw"):
			symbolarray = player.get_node("activeRuneDraw").symbolarray
			player.get_node("activeRuneDraw").queue_free()
		else:
			activeRuneDraw = runedraw.instantiate()
			activeRuneDraw.name = "activeRuneDraw"
			player.add_child(activeRuneDraw)
	
	
	if Input.is_action_pressed("left_click") && player.Stamina >= 0 && player.Fokus > 0 && casttime != null:
		casttime = min(10, casttime + delta)
		player.get_node("activeCastMeter/bar").value = casttime
	
	
	
	if Input.is_action_just_released("left_click"):
		#Cleanup
		is_casting = false
		if player.get_node("activeCastMeter"):
			player.get_node("activeCastMeter").queue_free()
		_open_spelldraw()
		casttime = null
	

func _open_spelldraw():
	if symbolarray != []:
		cast_spell()
	if player.get_node("activeRuneDraw"):
		if is_casting == false:
			cast_spell()
		player.get_node("activeRuneDraw").queue_free()
			
			
	elif casttime != null and is_casting == true:
		activeRuneDraw = runedraw.instantiate()
		activeRuneDraw.name = "activeRuneDraw"
		player.add_child(activeRuneDraw)


func _on_animation_player_animation_finished():
	pass



func cast_spell():
	if not casttime == null:
		if player.get_node("activeRuneDraw") or symbolarray != []:
			var spell = []
			if player.get_node("activeRuneDraw"):
				symbolarray = player.get_node("activeRuneDraw").symbolarray
			print(symbolarray)
			spell = ["DownLeft", "LeftUp", "Right","DownLeft"]
			if spell.hash() == symbolarray.hash():
				if casttime >= 3 && player.Ocupied <= 0 && player.Stamina >= 2 && player.Fokus >= 1:
					activeSpell = darkknife.instantiate()
					activeSpell.name = "activeDarkKnife"
					activeSpell.position = player.position 
					activeSpell.position.y -= 20
					player.Fokus -= 2
					player.Stamina -= 2
					game.add_child(activeSpell)
					symbolarray = []
	symbolarray = []
	pass
