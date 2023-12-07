extends Node2D

var weaponEffect = preload("res://Weapons/WeaponEffect.tscn")
var activeWeaponEffect = null


func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		activeWeaponEffect = weaponEffect.instantiate()
		activeWeaponEffect.name = "activeWeaponEffect"
		self.add_child(activeWeaponEffect)
	if Input.is_action_just_released("left_click"):
		$activeWeaponEffect.queue_free()
