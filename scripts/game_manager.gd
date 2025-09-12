extends Node

var score: int = 0
var player_health: int = 3
var level: int = 1

# Stats tracking
var level_stats: Array = []  # Each element: {"level": 1, "score": 10, "deaths": 2}
var deaths_in_level: int = 0

func add_score(amount: int = 1):
	score += amount

func lose_life():
	player_health -= 1
	deaths_in_level += 1

func start_level(level_number: int):
	level = level_number
	deaths_in_level = 0

func end_level():
	level_stats.append({
		"level": level,
		"score": score,
		"deaths": deaths_in_level
	})

func reset():
	score = 0
	player_health = 3
	level = 1
	deaths_in_level = 0
	level_stats.clear()
