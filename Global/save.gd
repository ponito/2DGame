extends Node


const SAVE_PATH  = "res://savegame.bin"




func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHealth": master.playerHealth,
		"maxplayerHealth": master.maxplayerHealth,
		"playerKnowledge": master.playerKnowledge
		
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)


func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var curren_line = JSON.parse_string(file.get_line())
			if curren_line:
				master.playerHealth = curren_line["playerHealth"]
				master.maxplayerHealth = curren_line["maxplayerHealth"]
				master.playerKnowledge = curren_line["playerKnowledge"]


