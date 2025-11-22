extends Node

var save_path = "user://savegame.json"

var data = {
	"current_level": 1,
	"player_health": 3,
	"score": 0,
	"collected_food": [],
	"collected_hearts": [],
	"current_level_deaths": 0,
	"level_stats": []  
}

func save_game() -> void:
	data["current_level"] = GameManager.level
	data["player_health"] = GameManager.player_health
	data["score"] = GameManager.score
	data["collected_food"] = GameManager.collected_food
	data["collected_hearts"] = GameManager.collected_hearts
	data["current_level_deaths"] = GameManager.current_level_deaths
	data["level_stats"] = GameManager.level_stats  

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
			if not data.has("collected_hearts"):
				data["collected_hearts"] = []
			if not data.has("current_level_deaths"):
				data["current_level_deaths"] = 0
			if not data.has("level_stats"):  
				data["level_stats"] = []

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
		"collected_food": [],
		"collected_hearts": [],
		"current_level_deaths": 0,
		"level_stats": []  
	}
	if FileAccess.file_exists(save_path):
		DirAccess.remove_absolute(save_path)
	print("🗑️ Save file deleted")

func apply_to_game() -> void:
	GameManager.level = data.get("current_level", 1)
	GameManager.player_health = data.get("player_health", 3)
	GameManager.score = data.get("score", 0)
	GameManager.saved_food = data.get("collected_food", [])
	GameManager.collected_hearts = data.get("collected_hearts", [])
	GameManager.current_level_deaths = data.get("current_level_deaths", 0)
	GameManager.level_stats = data.get("level_stats", []) 
	print("🎮 Save data applied to GameManager")
