extends Control

@onready var hearts = $bottom_left/hearts
@onready var food_bar = $bottom_left/food
@onready var water_bar = $bottom_left/water
@onready var torches = $top_right/torches

func lose_life():
	hearts.set_condition(-1)

func gain_life():
	hearts.set_condition(1)
