extends Node2D
var Test
var close = false
func _ready():
	$Label.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("E"):
		if close == true:
			master.X = get_node("../player/player").position.x
			master.Y = get_node("../player/player").position.y
			get_node("../player/player").Stamina = master.maxplayerStamina #Instant Stamina Restore
			master.playerHealth = get_node("../player/player").Health #Saving of Health
			get_node("../player/player").Health = master.maxplayerHealth #Instant Restoration
			master.playerHealth = master.maxplayerHealth #Only for Hp Restoration, overwrites Upper Save
			master.playerKnowledge = get_node("../player/player").Knowledge #Saving of Knowledge 
			save.saveGame()
			print("Saved")


func _on_area_2d_body_entered(body):
	$Label.show()
	close = true
	


func _on_area_2d_body_exited(body):
	$Label.hide()
	close = false
