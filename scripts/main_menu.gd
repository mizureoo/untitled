extends Control

@onready var button_container: VBoxContainer = $ButtonContainer
@onready var settings_panel: Panel = $SettingsPanel
@onready var credits_panel: Panel = $CreditsPanel

@onready var music_slider: HSlider = $"SettingsPanel/Volume/Music Volume/MusicSlider"
@onready var sfx_slider: HSlider = $"SettingsPanel/Volume/SFX Volume/SFXSlider"
@onready var mute_button: CheckButton = $"SettingsPanel/Volume/Mute All/MuteButton"
@onready var reset_button: Button = $SettingsPanel/Reset

func _ready() -> void:
	button_container.visible = true
	settings_panel.visible = false
	credits_panel.visible = false
	mute_button.toggled.connect(_on_mute_button_toggled)
	music_slider.value_changed.connect(_on_music_slider_value_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_value_changed)

	# Load values from Settings (autoload)
	music_slider.value = Settings.music_volume
	sfx_slider.value = Settings.sfx_volume
	mute_button.button_pressed = Settings.mute

	# Apply them to audio buses
	_apply_audio_settings()

func _apply_audio_settings() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(Settings.music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(Settings.sfx_volume))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), Settings.mute)

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

func _on_reset_pressed() -> void:
	# Reset values in Settings
	Settings.music_volume = 0.5
	Settings.sfx_volume = 0.5
	Settings.mute = false

	# Update UI
	music_slider.value = Settings.music_volume
	sfx_slider.value = Settings.sfx_volume
	mute_button.button_pressed = Settings.mute

	# Apply to audio buses
	_apply_audio_settings()

func _on_music_slider_value_changed(value: float) -> void:
	Settings.music_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	Settings.sfx_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))

func _on_mute_button_toggled(toggled_on: bool) -> void:
	Settings.mute = toggled_on
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
