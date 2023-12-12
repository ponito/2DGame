extends Node2D

var weaponEffect = preload("res://Weapons/WeaponEffect.tscn")
var activeWeaponEffect = null
var anim_name = null
@onready var player = get_node("../../..")
@onready var anim = get_node("../../../AnimationPlayer")

func _process(delta):
	if Input.is_action_just_pressed("left_click") && player.Ocupied == 0 && player.Stamina > 0:
		player.velocity.x *= 0.1
		player.Stamina -= 2
		get_node("../../..").Ocupied = 1
		activeWeaponEffect = weaponEffect.instantiate()
		activeWeaponEffect.name = "activeWeaponEffect"
		self.add_child(activeWeaponEffect)
		anim.play("Attack")
		





func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		player.Ocupied = 0
		$activeWeaponEffect.queue_free()

