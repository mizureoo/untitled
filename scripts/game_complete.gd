extends Control

@onready var stats_label: Label = $StatsLabel
@onready var retry_button: Button = $HBoxContainer/Retry

func _ready():
	# Show a "Game Completed" message and stats
	var text = "Congratulations! You completed the game!\n\n"
	for level_data in GameManager.level_stats:
		text += "Level %d → Score: %d, Deaths: %d\n" % [
			level_data.level,
			level_data.score,
			level_data.deaths
		]
	stats_label.text = text
	
func _on_quit_pressed():
	get_tree().quit()
