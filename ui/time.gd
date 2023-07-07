extends Label

func _physics_process(delta):
	#print(Global.time_left)
	if Global.time_left > 0:
		self.text = "%02d:%02d" % [fmod(Global.time_left, 60*60) / 60, fmod(Global.time_left, 60)]
