extends Node

var score: int = 0
var level: int = 1
var total_levels: int = 2  # set this to the total number of levels
var player_health: int = 3
var level_stats := []  # array to store score/deaths per level

func add_score(amount: int = 1):
	score += amount

func lose_life():
	player_health -= 1

func reset():
	score = 0
	level = 1
	player_health = 3
	level_stats.clear()

func start_level(level_number: int):
	# Called when starting a level to reset per-level stats
	level = level_number
	# You can also store deaths per level if needed
	level_stats.append({"level": level, "score": score, "deaths": 0})

func end_level():
	# Called when finishing a level
	# Update stats for the level
	if level_stats.size() > 0:
		level_stats[-1]["score"] = score
