extends Node2D

var darkknife = preload("res://Weapons/projectiles/Darkknife.tscn")
var castmeter = preload("res://Player/castmeter.tscn")
var runedraw = preload("res://Player/runedraw.tscn")
var activeSpell = null
var activeCastMeter = null
var anim_name = null
var Knockback = 1
var castposition 
var casttime = null

var Rune1 = null
var Rune2 = null
var Rune3 = null

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
	
	if Input.is_action_just_pressed("left_click") && player.Stamina >= 0 && player.Fokus > 0 && casttime == null:
		activeCastMeter = castmeter.instantiate()
		activeCastMeter.name = "activeCastMeter"
		#activeCastMeter.position = player.position 
		activeCastMeter.position.y -= 25
		player.add_child(activeCastMeter)
		casttime = 0
		
		activeSpell = runedraw.instantiate()
		activeSpell.name = "activeSpell"
		self.add_child(activeSpell)
	
	
	if Input.is_action_pressed("left_click") && player.Stamina >= 0 && player.Fokus > 0 && casttime != null:
		casttime = min(10, casttime + delta)
		player.get_node("activeCastMeter/bar").value = casttime
		pass
	
	
	
	if Input.is_action_just_released("left_click"):
		if casttime >= 3 && player.Ocupied <= 0 && player.Stamina >= 2 && player.Fokus >= 1:
			activeSpell = darkknife.instantiate()
			activeSpell.name = "activeDarkKnife"
			activeSpell.position = player.position 
			activeSpell.position.y -= 20
			player.Fokus -= 1
			player.Stamina -= 2
			game.add_child(activeSpell)
		casttime = null
		player.get_node("activeCastMeter").queue_free()
		get_node("activeSpell").queue_free()

func _on_animation_player_animation_finished():
	pass
