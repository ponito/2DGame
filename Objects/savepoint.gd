extends Node2D
var Test
var close = false
@onready var player = get_node("../../player/player")
func _ready():
	$Label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("E"):
		if close == true:
			master.X = player.position.x
			master.Y = player.position.y
			player.Stamina = master.maxplayerStamina #Instant Stamina Restore
			master.playerHealth = player.Health #Saving of Health
			player.Health = master.maxplayerHealth #Instant Restoration
			master.playerHealth = master.maxplayerHealth #Only for Hp Restoration, overwrites Upper Save
			master.playerKnowledge = player.Knowledge #Saving of Knowledge 
			$Label.hide()
			save.saveGame()


func _on_area_2d_body_entered(body):
	if body == player:
		$Label.show()
		close = true
	


func _on_area_2d_body_exited(body):
	if body == player:
		$Label.hide()
		close = false
