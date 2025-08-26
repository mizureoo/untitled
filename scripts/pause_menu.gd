extends Control

@onready var pause_menu: Control = $"."
@onready var grid_container: GridContainer = $GridContainer

var _is_paused:bool = false:
	set = set_paused
	
func _ready() -> void:
	pause_menu.visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_is_paused = !_is_paused

func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused
	
func _on_resume_pressed() -> void:
	_is_paused = false
	
func _on_return_pressed() -> void:
	get_tree().paused = false 
	SceneManager.change_scene("res://scenes/main_menu.tscn")

func _on_back_pressed() -> void:
	grid_container.visible = true
