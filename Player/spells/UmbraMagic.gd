extends Node2D


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
signal spellbookcast
signal spellbooktest

var symbolarray = []

@onready var game = get_node("../../../../..")
@onready var player = get_node("../../..")
@onready var spellbookfile = player.get_node("Inventory/spellbook")
@onready var anim = get_node("../../../AnimationPlayer")
@onready var handconnect = get_node("../../Skeleton2D/hip/spine/armleft1/armleft2/armleft3/handleft/RemoteTransform2D")


func _ready():
	#connected die Waffe per Code, falls die Waffe gewechselt wird
	anim.animation_finished.connect(_on_animation_player_animation_finished)
	handconnect.remote_path = "../../../../../../../../armleft/UmbralMagic"
	self.spellbookcast.connect(spellbookfile.spellbook)
	self.spellbooktest.connect(spellbookfile.spelltest)
	




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
			spellbooktest.emit(casttime, player.Ocupied, player.Fokus, player.Stamina,symbolarray)
			player.get_node("activeRuneDraw").queue_free()
		elif player.Stamina >= 0 && player.Fokus > 0 && casttime == null && player.Ocupied != 1:
			activeRuneDraw = runedraw.instantiate()
			activeRuneDraw.name = "activeRuneDraw"
			player.add_child(activeRuneDraw)
	
	
	if Input.is_action_pressed("left_click") && player.Stamina >= 0 && player.Fokus > 0 && casttime != null:
		if player.velocity.x > 0.1 or player.velocity.x < -0.1:
			casttime = min(10, casttime + delta/1.5)
		else:
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
			if player.get_node("activeRuneDraw"):
				symbolarray = player.get_node("activeRuneDraw").symbolarray
				spellbooktest.emit(casttime, player.Ocupied, player.Fokus, player.Stamina,symbolarray)
			spellbookcast.emit(casttime, player.Ocupied, player.Fokus, player.Stamina)
	symbolarray = []
	pass
