extends Node

var save_path = "user://savegame.json"

# Default data
var data = {
	"current_level": 1,
	"player_health": 3,
	"score": 0,
	"collected_food": []  # runtime pizzas/food
}

# Track if player saved manually THIS SESSION
var _manual_save_this_session: bool = false

func save_game() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
		_manual_save_this_session = true  # mark that player saved this session
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

# Only show Continue if the player saved manually THIS SESSION
func has_save() -> bool:
	return _manual_save_this_session and FileAccess.file_exists(save_path)

# Reset in-memory and disk save
func reset_save() -> void:
	data = {
		"current_level": 1,
		"player_health": 3,
		"score": 0,
		"collected_food": []
	}
	_manual_save_this_session = false
	save_game()

func apply_to_game() -> void:
	if Engine.has_singleton("GameManager") or GameManager != null:
		GameManager.level = data.get("current_level", 1)
		GameManager.player_health = data.get("player_health", 3)
		GameManager.score = data.get("score", 0)
		print("🎮 Save data applied to GameManager")
