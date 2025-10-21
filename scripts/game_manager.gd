extends Node

# Player stats
var score: int = 0
var level: int = 1
var total_levels: int = 3
var player_health: int = 3

# Food collections
var collected_food = []  # runtime only
var saved_food = []      # updated only when saving

# Stats per level
var level_stats := []  # each item: {"level": int, "score": int, "deaths": int}
var current_level_deaths: int = 0


# --- Score ---
func add_score(amount: int = 1):
	score += amount


# --- Life management ---
func lose_life():
	player_health -= 1
	current_level_deaths += 1


# --- Reset everything ---
func reset(full_reset: bool):
	score = 0
	level = 1
	player_health = 3
	current_level_deaths = 0
	collected_food.clear()  # always reset runtime collection
	if full_reset:
		level_stats.clear()
		saved_food.clear()


# --- Level lifecycle ---
func start_level(level_number: int):
	level = level_number
	current_level_deaths = 0
	collected_food.clear()  # fresh for this session

	# optionally restore saved food if continuing from a save
	if saved_food.size() > 0:
		collected_food = saved_food.duplicate()


func end_level():
	level_stats.append({
		"level": level,
		"score": score,
		"deaths": current_level_deaths
	})


# --- Food collection ---
func collect_food(food_id):
	if food_id not in collected_food:
		collected_food.append(food_id)


# --- Save / load ---
func save_game():
	saved_food = collected_food.duplicate()
	# also save level_stats, score, etc. as needed

func delete_save():
	var file_path = "user://savegame.json"

	# Check if the save file exists
	if FileAccess.file_exists(file_path):
		var dir = DirAccess.open("user://")
		if dir != null:
			dir.remove("savegame.json")
			saved_food.clear()
			print("✅ Save file deleted successfully")
		else:
			print("❌ Failed to open user directory")
	else:
		print("❌ No save file found")
