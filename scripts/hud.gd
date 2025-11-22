extends Control
class_name HUD

@export var score_label: Label
@export var health_label: Label

func _ready():
	GameManager.score_changed.connect(_on_GameManager_score_changed)
	GameManager.health_changed.connect(_on_GameManager_health_changed)

	_on_GameManager_score_changed(GameManager.score)
	_on_GameManager_health_changed(GameManager.player_health)

func _on_GameManager_score_changed(new_score: int) -> void:
	score_label.text = " " + str(new_score)

func _on_GameManager_health_changed(new_health: int) -> void:
	health_label.text = " " + str(new_health)
