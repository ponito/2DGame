extends Node2D
var EnemyHyperArmor = 0
@onready var player = get_node("../../../..")
@onready var weapon = get_node("..")


func _on_ready():
	modulate.a=0

func _on_area_2d_body_entered(body):
	var direction = (body.position - player.position).normalized()
	var KnockBackResist = 0
	if "KnockBackResist" in body:
		KnockBackResist = body.KnockBackResist
	
	if weapon.Knockback > KnockBackResist:
		body.position.y += -5
	body.velocity.y = sign(direction.y) - max(0, 100 -KnockBackResist*100)
	body.velocity.x = sign(direction.x) * 300 * max(0, weapon.Knockback - KnockBackResist)
	if "HyperArmor" in body:
		EnemyHyperArmor = EnemyHyperArmor + body.HyperArmor
	else:
		pass
	body.Health -= 20
	#body.velocity.x += sign(direction.x) * 500
