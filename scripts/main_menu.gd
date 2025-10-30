extends Control

# --- Nodes ---
@onready var button_container: VBoxContainer = $ButtonContainer
@onready var settings_panel: Panel = $SettingsPanel
@onready var credits_panel: Panel = $CreditsPanel

@onready var music_slider: HSlider = $"SettingsPanel/Volume/Music Volume/MusicSlider"
@onready var sfx_slider: HSlider = $"SettingsPanel/Volume/SFX Volume/SFXSlider"
@onready var mute_button: CheckButton = $"SettingsPanel/Volume/Mute All/MuteButton"
@onready var reset_button: Button = $SettingsPanel/ResetButton
@onready var back_button: Button = $SettingsPanel/Return

@onready var new_game_button = $ButtonContainer/NewGame
@onready var continue_button = $ButtonContainer/Continue


# --- Ready ---
func _ready():
	button_container.visible = true
	settings_panel.visible = false
	credits_panel.visible = false
	
	continue_button.visible = SaveManager.has_save()

	# Load settings and apply audio once
	Settings.load_settings()
	_apply_audio_settings()


# --- Game Buttons ---
func _on_new_game_pressed():
	GameManager.reset(true)
	SaveManager.reset_save()
	SceneManager.change_scene("res://scenes/levels/level_1.tscn")
	
func _on_continue_pressed():
	if SaveManager.has_save():
		SaveManager.load_game()
		SaveManager.apply_to_game()
		var level = SaveManager.data.get("current_level", 1)
		SceneManager.change_scene("res://scenes/levels/level_%d.tscn" % level)

# --- Audio ---
func _apply_audio_settings():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(Settings.music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(Settings.sfx_volume))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), Settings.mute)

func _load_settings_to_ui():
	# Only update UI if values differ (prevents slider feedback)
	if music_slider.value != Settings.music_volume:
		music_slider.value = Settings.music_volume
	if sfx_slider.value != Settings.sfx_volume:
		sfx_slider.value = Settings.sfx_volume
	if mute_button.button_pressed != Settings.mute:
		mute_button.button_pressed = Settings.mute

	_apply_audio_settings()

# --- Button callbacks ---
func _on_settings_pressed():
	button_container.visible = false
	settings_panel.visible = true

func _on_credits_pressed():
	button_container.visible = false
	credits_panel.visible = true

func _on_quit_pressed():
	get_tree().quit()

func _on_reset_pressed():
	Settings.music_volume = 0.3
	Settings.sfx_volume = 0.1
	Settings.mute = false
	_apply_audio_settings()
	Settings.save_settings()
	_load_settings_to_ui()

func _on_back_from_settings():
	settings_panel.visible = false
	button_container.visible = true
	Settings.save_settings()

# --- Slider / Toggle callbacks ---
func _on_music_slider_value_changed(value: float):
	if Settings.music_volume == value:
		return
	Settings.music_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
	Settings.save_settings()

func _on_sfx_slider_value_changed(value: float):
	if Settings.sfx_volume == value:
		return
	Settings.sfx_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	Settings.save_settings()

func _on_mute_button_toggled(toggled_on: bool):
	if Settings.mute == toggled_on:
		return
	Settings.mute = toggled_on
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
	Settings.save_settings()

func _on_settings_panel_visibility_changed() -> void:
	if settings_panel.visible:
		_load_settings_to_ui()
