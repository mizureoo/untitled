extends Node

# Player stats
var score: int = 0
var level: int = 1
var total_levels: int = 3  # Hardcoded total levels
var player_health: int = 3

# Stats per level
var level_stats := []  # each item: {"level": int, "score": int, "deaths": int}
var current_level_deaths: int = 0


# Score
func add_score(amount: int = 1):
	score += amount


# Life management
func lose_life():
	player_health -= 1
	current_level_deaths += 1


# Reset everything
func reset():
	score = 0
	level = 1
	player_health = 3
	level_stats.clear()
	current_level_deaths = 0


# Level lifecycle
func start_level(level_number: int):
	level = level_number
	current_level_deaths = 0


func end_level():
	level_stats.append({
		"level": level,
		"score": score,
		"deaths": current_level_deaths
	})
