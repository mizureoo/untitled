extends Control

@onready var stats_label: Label = $StatsLabel
@onready var quit_button: Button = $HBoxContainer/Quit
@onready var return_button: Button = $HBoxContainer/Return

func _ready():
	var text = "Congratulations! You completed the game!\n\n"
	for level_data in GameManager.level_stats:
		text += "Level %d → Score: %d, Deaths: %d\n" % [
			level_data.level,
			level_data.score,
			level_data.deaths
		]
	stats_label.text = text

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_return_pressed() -> void:
		GameManager.reset()  # reset score, health, level, stats
		SceneManager.change_scene("res://scenes/main_menu.tscn")
