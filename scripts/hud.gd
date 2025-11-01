extends Control
class_name HUD

@export var score_label: Label
@export var health_label: Label

func _ready():
	# ✅ Correct Godot 4 signal connection syntax
	GameManager.score_changed.connect(_on_GameManager_score_changed)
	GameManager.health_changed.connect(_on_GameManager_health_changed)

	# Initialize labels
	_on_GameManager_score_changed(GameManager.score)
	_on_GameManager_health_changed(GameManager.player_health)

# --- Update score label ---
func _on_GameManager_score_changed(new_score: int) -> void:
	score_label.text = " " + str(new_score)

# --- Update health label ---
func _on_GameManager_health_changed(new_health: int) -> void:
	health_label.text = " " + str(new_health)
