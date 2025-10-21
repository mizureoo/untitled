extends Control

@onready var stats_label: Label = $StatsLabel
@onready var retry_button: Button = $HBoxContainer/Retry
@onready var quit_button: Button = $HBoxContainer/Quit

func _ready():
	var text = ""
	for level_data in GameManager.level_stats:
		text += "Level %d → Score: %d, Deaths: %d\n" % [
			level_data.level,
			level_data.score,
			level_data.deaths
		]
	stats_label.text = text

func _on_retry_pressed():
	GameManager.reset(true)
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_quit_pressed():
	get_tree().quit()
