extends Node2D

var weaponEffect = preload("res://Weapons/WeaponEffect.tscn")
var activeWeaponEffect = null
@onready var anim = get_node("../../../AnimationPlayer")

func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		activeWeaponEffect = weaponEffect.instantiate()
		activeWeaponEffect.name = "activeWeaponEffect"
		self.add_child(activeWeaponEffect)
		anim.play("Attack")
		print(anim)
	if Input.is_action_just_released("left_click"):
		$activeWeaponEffect.queue_free()
