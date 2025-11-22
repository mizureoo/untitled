extends AudioStreamPlayer

func _ready():
	if not playing:
		play()

func play_music(new_stream: AudioStream):
	if new_stream == self.stream and playing:
		return 
	self.stream = new_stream
	play()

func stop_music():
	if playing:
		stop()
