extends Node

var score: int = 0
var level: int = 1
var total_levels: int = 0
var player_health: int = 3

var level_stats := []  # each item: {"level": int, "score": int, "deaths": int}
var current_level_deaths: int = 0


func _ready():
	# Count levels dynamically at startup
	_scan_levels()


func _scan_levels():
	var dir = DirAccess.open("res://scenes/levels")
	if dir:
		for file_name in dir.get_files():
			if file_name.begins_with("level_") and file_name.ends_with(".tscn"):
				total_levels += 1
	print("Detected total levels:", total_levels)


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
	level_stats.append({
		"level": level,
		"score": score,
		"deaths": current_level_deaths
	})
