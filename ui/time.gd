extends Label

func _physics_process(delta):
	if Global.time_survived > 0:
		self.text = "%02d:%02d" % [fmod(Global.time_survived, 60*60) / 60, fmod(Global.time_survived, 60)]
