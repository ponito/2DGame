extends Node2D

var weaponEffect = preload("res://Weapons/WeaponEffect.tscn")
var activeWeaponEffect = null
@onready var player = get_node("../../..")
@onready var anim = get_node("../../../AnimationPlayer")

func _process(delta):
	if Input.is_action_just_pressed("left_click") && player.Ocupied == 0:
		get_node("../../..").Ocupied = 1
		activeWeaponEffect = weaponEffect.instantiate()
		activeWeaponEffect.name = "activeWeaponEffect"
		self.add_child(activeWeaponEffect)
		anim.play("Attack")
		
	#if Input.is_action_just_released("left_click"):
		#$activeWeaponEffect.queue_free()





func _on_animation_player_animation_finished(anim_name):
	player.Ocupied = 0
	if anim_name == "Attack":
		$activeWeaponEffect.queue_free()
	pass
	pass # Replace with function body.
