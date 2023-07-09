extends Control

signal start_again()

@onready var label = $Panel/Label2

func set_time():
	label.text = "Your time: %02d:%02d" % [fmod(Global.time_survived, 60*60) / 60, fmod(Global.time_survived, 60)]

func _on_button_button_down():
	start_again.emit()
