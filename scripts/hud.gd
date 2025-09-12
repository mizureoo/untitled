extends Control
class_name HUD

@export var score_label: Label
@export var health_label: Label

func _process(_delta):
	score_label.text = " " + str(GameManager.score)
	health_label.text = " " + str(GameManager.player_health)
