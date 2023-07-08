extends Node

var time_survived: float

func _ready():
	prepare_game()

func _physics_process(delta):
	time_survived += delta

func prepare_game():
	time_survived = 0
