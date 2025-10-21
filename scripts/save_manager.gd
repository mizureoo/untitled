extends Node

var save_path := "user://savegame.json"

# Default data
var data := {
	"current_level": 1,
	"score": 0,
	"player_health": 3
}

# Save progress to JSON file
func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))  # formatted with tabs
		file.close()
		print("✅ Game saved as JSON!")

# Load progress from JSON file
func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var content = file.get_as_text()
		file.close()

		var parsed = JSON.parse_string(content)
		if typeof(parsed) == TYPE_DICTIONARY:
			data = parsed
			print("✅ Game loaded!")
		else:
			print("⚠️ Invalid JSON structure!")
	else:
		print("⚠️ No save file found, creating new one...")
		save_game()

# Delete the save file
func reset_save():
	if FileAccess.file_exists(save_path):
		var dir = DirAccess.open("user://")
		if dir:
			dir.remove("savegame.json")
			print("🗑️ Save file deleted.")
	data = {
		"current_level": 1,
		"score": 0,
		"player_health": 3
	}
	save_game()

func has_save() -> bool:
	return FileAccess.file_exists(save_path)


func apply_to_game():
	if Engine.has_singleton("GameManager"):
		var gm = GameManager
		gm.score = data.get("score", 0)
		gm.player_health = data.get("player_health", 3)
		gm.level = data.get("current_level", 1)
		print("🎮 Game state restored from save file.")
