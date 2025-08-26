extends Control

@onready var button_container: VBoxContainer = $ButtonContainer
@onready var settings_panel: Panel = $SettingsPanel
@onready var credits_panel: Panel = $CreditsPanel

@onready var music_slider: HSlider = $"SettingsPanel/Volume/Music Volume/MusicSlider"
@onready var sfx_slider: HSlider = $"SettingsPanel/Volume/SFX Volume/SFXSlider"
@onready var mute_button: CheckButton = $"SettingsPanel/Volume/Mute All/MuteButton"
@onready var reset_button: Button = $SettingsPanel/Reset

const DEFAULT_MUSIC_VOLUME: float = 0.8
const DEFAULT_SFX_VOLUME: float = 0.8
const DEFAULT_MUTE: bool = false

func _ready() -> void:
	button_container.visible = true
	settings_panel.visible = false
	credits_panel.visible = false
	mute_button.toggled.connect(_on_mute_button_toggled)
	
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
	# Reset UI
	music_slider.value = DEFAULT_MUSIC_VOLUME
	sfx_slider.value = DEFAULT_SFX_VOLUME
	mute_button.button_pressed = DEFAULT_MUTE

	# Apply to Audio buses
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(DEFAULT_MUSIC_VOLUME))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(DEFAULT_SFX_VOLUME))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), DEFAULT_MUTE)

func _on_mute_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
