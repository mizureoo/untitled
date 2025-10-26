extends HSlider

@export var audio_bus_name: String
var audio_bus_id: int

func _ready() -> void:
	# Get the bus index
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	
	# Initialize slider value from Settings or current audio bus
	match audio_bus_name:
		"Music":
			if value != Settings.music_volume:
				value = Settings.music_volume
		"SFX":
			if value != Settings.sfx_volume:
				value = Settings.sfx_volume
		_:
			value = db_to_linear(AudioServer.get_bus_volume_db(audio_bus_id))

func _on_value_changed(new_value: float) -> void:
	# Apply new volume to the audio bus
	var db = linear_to_db(new_value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)

	# Update Settings if necessary
	match audio_bus_name:
		"Music":
			if Settings.music_volume != new_value:
				Settings.music_volume = new_value
				Settings.save_settings()
		"SFX":
			if Settings.sfx_volume != new_value:
				Settings.sfx_volume = new_value
				Settings.save_settings()
