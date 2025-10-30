extends Node

var music_volume: float = 0.3
var sfx_volume: float = 0.1
var mute: bool = false

const SETTINGS_FILE := "user://settings.save"

func _ready():
	load_settings()
	_apply_on_load()

func save_settings():
	var data = {
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"mute": mute
	}
	var file = FileAccess.open(SETTINGS_FILE, FileAccess.WRITE)
	file.store_var(data)
	file.close()

func load_settings():
	if FileAccess.file_exists(SETTINGS_FILE):
		var file = FileAccess.open(SETTINGS_FILE, FileAccess.READ)
		var data = file.get_var()
		file.close()
		music_volume = data.get("music_volume", 0.3)
		sfx_volume = data.get("sfx_volume", 0.3)
		mute = data.get("mute", false)

func _apply_on_load():
	# Automatically apply loaded audio levels
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx_volume))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), mute)
