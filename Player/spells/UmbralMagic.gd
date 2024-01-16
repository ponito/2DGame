extends Node2D

var darkknife = preload("res://Weapons/projectiles/Darkknife.tscn")
var activeDarkKnife = null
var anim_name = null
var Knockback = 1
var castposition 

@onready var game = get_node("../../../../..")
@onready var player = get_node("../../..")
@onready var anim = get_node("../../../AnimationPlayer")
@onready var handconnect = get_node("../../Skeleton2D/hip/spine/armleft1/armleft2/armleft3/handleft/RemoteTransform2D")


func _ready():
	#connected die Waffe per Code, falls die Waffe gewechselt wird
	anim.animation_finished.connect(_on_animation_player_animation_finished)
	handconnect.remote_path = "../../../../../../../../armleft/UmbralMagic"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	
	
	if Input.is_action_just_released("left_click") && player.Ocupied <= 0 && player.Stamina > 2 && player.Fokus > 1:
		activeDarkKnife = darkknife.instantiate()
		activeDarkKnife.name = "activeDarkKnife"
		activeDarkKnife.position = player.position 
		activeDarkKnife.position.y -= 20
		player.Fokus -= 1
		game.add_child(activeDarkKnife)
		
	pass

func _on_animation_player_animation_finished():
	pass
