extends Control

@onready var button_container: VBoxContainer = $ButtonContainer
@onready var settings_panel: Panel = $SettingsPanel
@onready var credits_panel: Panel = $CreditsPanel

func _ready() -> void:
	button_container.visible = true
	settings_panel.visible = false
	credits_panel.visible = false
	
func _on_play_pressed() -> void:
	SceneManager.change_scene("res://scenes/level_1.tscn")

func _on_settings_pressed() -> void:
	button_container.visible = false
	settings_panel.visible = true

func _on_credits_pressed() -> void:
	button_container.visible = false
	credits_panel.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()
