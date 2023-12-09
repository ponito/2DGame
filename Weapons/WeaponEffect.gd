extends Node2D
var EnemyHyperArmor = 0
@onready var player = get_node("../../../..")

func _on_area_2d_body_entered(body):
	var direction = (body.position - player.position).normalized()
	body.velocity.x = sign(direction.x) * 150
	body.velocity.y = sign(direction.y) * 100
	if "HyperArmor" in body:
		EnemyHyperArmor = EnemyHyperArmor + body.HyperArmor
	else:
		pass
	body.Health -= 20
	#body.velocity.x += sign(direction.x) * 500
