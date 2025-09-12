extends Node

var score: int = 0
var level: int = 1
var total_levels: int = 2
var player_health: int = 3

# Store stats for each level: score and deaths
var level_stats := []  # each item: {"level": int, "score": int, "deaths": int}
var current_level_deaths: int = 0

func add_score(amount: int = 1):
	score += amount

func lose_life():
	player_health -= 1
	current_level_deaths += 1

func reset():
	score = 0
	level = 1
	player_health = 3
	level_stats.clear()
	current_level_deaths = 0

func start_level(level_number: int):
	level = level_number
	current_level_deaths = 0

func end_level():
	# Save stats for this level
	level_stats.append({
		"level": level,
		"score": score,
		"deaths": current_level_deaths
	})
