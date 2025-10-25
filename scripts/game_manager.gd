extends Node

var score: int = 0
var level: int = 1
var total_levels: int = 3
var player_health: int = 3

var collected_food = []
var saved_food = []
var level_stats = []
var current_level_deaths: int = 0

# --- Add score ---
func add_score(amount: int = 1):
	score += amount

# --- Lose life ---
func lose_life():
	player_health -= 1
	current_level_deaths += 1

# --- Reset ---
func reset(full_reset: bool):
	score = 0
	level = 1
	player_health = 3
	current_level_deaths = 0
	collected_food.clear()
	if full_reset:
		level_stats.clear()
		saved_food.clear()

# --- Start level ---
func start_level(level_number: int):
	level = level_number
	current_level_deaths = 0
	collected_food.clear()
	if saved_food.size() > 0:
		collected_food = saved_food.duplicate()

# --- End level ---
func end_level():
	level_stats.append({
		"level": level,
		"score": score,
		"deaths": current_level_deaths
	})

# --- Collect food ---
func collect_food(food_id):
	if food_id not in collected_food:
		collected_food.append(food_id)

# --- Save ---
func save_game():
	saved_food = collected_food.duplicate()

# --- Delete save (called only when game completed) ---
func delete_save():
	var file_path = "user://savegame.json"
	if FileAccess.file_exists(file_path):
		DirAccess.remove_absolute(file_path)
		saved_food.clear()
