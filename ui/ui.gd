extends Control

signal condition_fulfilled(id)
signal mistake()

@onready var hearts = $bottom_left/hearts
@onready var food_bar = $bottom_left/food
@onready var water_bar = $bottom_left/water
@onready var torches = $top_right/torches_panel/torches

func lose_life():
	hearts.set_condition(-1)

func gain_life():
	hearts.set_condition(1)

func change_food_value(value, id):
	food_bar.set_condition(value, id)

func change_water_value(value, id):
	water_bar.set_condition(value, id)

func _on_food_condition_fulfilled(id):
	condition_fulfilled.emit(id)

func _on_food_mistake():
	mistake.emit()
