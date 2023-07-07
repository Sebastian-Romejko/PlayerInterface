extends Node

var default_time_left = 300

var time_left: float

func _ready():
	print(time_left)
	prepare_game()
	print(time_left)

func _physics_process(delta):
	time_left -= delta

func prepare_game():
	time_left = default_time_left
