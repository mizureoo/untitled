extends Control

@onready var pause_menu: Control = $"."
@onready var grid_container: GridContainer = $GridContainer

var _is_paused: bool = false:
	set = set_paused

func _ready() -> void:
	pause_menu.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_is_paused = !_is_paused

func set_paused(value: bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused

# Resume
func _on_resume_pressed() -> void:
	_is_paused = false

# Return to main menu WITHOUT saving
func _on_return_pressed() -> void:
	get_tree().paused = false
	GameManager.reset(false)
	SceneManager.change_scene("res://scenes/main_menu.tscn")

# Manual save only when player presses Save
func _on_save_game_pressed() -> void:
	SaveManager.data["current_level"] = GameManager.level
	SaveManager.data["score"] = GameManager.score
	SaveManager.data["player_health"] = GameManager.player_health
	SaveManager.data["collected_food"] = GameManager.collected_food
	SaveManager.save_game()
	print("✅ Game saved manually")

func _on_back_pressed() -> void:
	grid_container.visible = true
