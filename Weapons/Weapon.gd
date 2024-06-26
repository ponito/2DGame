extends Node2D
var weaponEffect = preload("res://Weapons/WeaponEffect.tscn")
var activeWeaponEffect = null

var Knockback = 1


@onready var player = get_node("../../..")
@onready var anim = get_node("../../../AnimationPlayer")
@onready var handconnect = get_node("../../Skeleton2D/hip/spine/armleft1/armleft2/armleft3/handleft/RemoteTransform2D")


var hitbox_scale_attack2 = Vector2(1.2,1.2)

func _ready():
	#connected die Waffe per Code, falls die Waffe gewechselt wird
	anim.animation_finished.connect(_on_animation_player_animation_finished)
	handconnect.remote_path = "../../../../../../../../armleft/Weapon"

func _process(_delta):
	if Input.is_action_just_pressed("left_click") && player.Ocupied == 0 && player.Stamina > 0:
		if Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
			var currentplayerspeed = player.velocity.x
			Knockback = 1.3
			player.velocity.x = +(currentplayerspeed -100)
			player.Stamina -= 2.5
			get_node("../../..").Ocupied = 1
			activeWeaponEffect = weaponEffect.instantiate()
			activeWeaponEffect.name = "activeWeaponEffect"
			activeWeaponEffect.scale *= hitbox_scale_attack2
			self.add_child(activeWeaponEffect)
			anim.play("Attack_2")
			
		if Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
			var currentplayerspeed = player.velocity.x
			Knockback = 1.3
			player.velocity.x = +(currentplayerspeed +100)
			player.Stamina -= 2.5
			get_node("../../..").Ocupied = 1
			activeWeaponEffect = weaponEffect.instantiate()
			activeWeaponEffect.name = "activeWeaponEffect"
			activeWeaponEffect.scale *= hitbox_scale_attack2
			self.add_child(activeWeaponEffect)
			anim.play("Attack_2")
		if not Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
			Knockback = 1
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
	if anim_name == "Attack_2":
		player.Ocupied = 0
		$activeWeaponEffect.queue_free()

#

