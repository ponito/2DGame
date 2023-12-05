extends Node2D
var Test
var close = false
func _ready():
	#$Label.show()
	$Label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("E"):
		if close == true:
			master.playerHealth = get_node("../player/player").Health
			master.playerKnowledge = get_node("../player/player").Knowledge 
			save.saveGame()
			print("Saved")


func _on_area_2d_body_entered(body):
	$Label.show()
	close = true
	


func _on_area_2d_body_exited(body):
	$Label.hide()
	close = false
