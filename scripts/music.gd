extends AudioStreamPlayer

func _ready():
	# Make sure music keeps playing after scene changes
	if not playing:
		play()

func play_music(new_stream: AudioStream):
	if new_stream == self.stream and playing:
		return # Don’t restart the same track
	self.stream = new_stream
	play()

func stop_music():
	if playing:
		stop()
