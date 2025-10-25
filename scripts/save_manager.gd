extends Node

var save_path = "user://savegame.json"

# Default data
var data = {
	"current_level": 1,
	"player_health": 3,
	"score": 0,
	"collected_food": []
}

func save_game() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
		print("✅ Game saved at " + save_path)

func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		var json = JSON.parse_string(content)
		if typeof(json) == TYPE_DICTIONARY:
			data = json
			if not data.has("collected_food"):
				data["collected_food"] = []
			print("✅ Game loaded successfully")
	else:
		print("⚠️ No save file found, using defaults")

func has_save() -> bool:
	return FileAccess.file_exists(save_path)

func reset_save() -> void:
	data = {
		"current_level": 1,
		"player_health": 3,
		"score": 0,
		"collected_food": []
	}
	if FileAccess.file_exists(save_path):
		DirAccess.remove_absolute(save_path)
	print("🗑️ Save file deleted")

func apply_to_game() -> void:
	GameManager.level = data.get("current_level", 1)
	GameManager.player_health = data.get("player_health", 3)
	GameManager.score = data.get("score", 0)
	GameManager.saved_food = data.get("collected_food", [])
	print("🎮 Save data applied to GameManager")
