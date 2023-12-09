extends Node2D
var EnemyHyperArmor = 0


func _on_area_2d_body_entered(body):
	body.Health -= 20
	EnemyHyperArmor = EnemyHyperArmor + body.EnemyHyperArmor
