extends Control

signal condition_fulfilled(id)
signal mistake()

@onready var hearts = $bottom_left/hearts
@onready var food_bar = $bottom_left/food
@onready var water_bar = $bottom_left/water
@onready var torches = $top_right/torches_panel/torches
@onready var mistakes = $bottom_right/mistakes

@onready var tasks = $tasks

func change_food_value(value, id, timeout):
	food_bar.set_condition(value, id)
	tasks.add_new_task(id, "food", value, timeout)

func change_water_value(value, id, timeout):
	water_bar.set_condition(value, id)
	tasks.add_new_task(id, "water", value, timeout)

func gain_torch(id, timeout):
	torches.set_condition(1, id)
	tasks.add_new_task(id, "torch", 1, timeout)

func lose_torch(id, timeout):
	torches.set_condition(0, id)
	tasks.add_new_task(id, "torch", -1, timeout)

func add_mistake(id, timeout):
	mistakes.set_condition(id)
	tasks.add_new_task(id, "mistake", 1, timeout)

func _on_food_condition_fulfilled(id):
	condition_fulfilled.emit(id)
	tasks.task_done(id)

func _on_water_condition_fulfilled(id):
	condition_fulfilled.emit(id)
	tasks.task_done(id)

func _on_torches_condition_fulfilled(id):
	condition_fulfilled.emit(id)
	tasks.task_done(id)

func _on_mistakes_condition_fulfilled(id):
	condition_fulfilled.emit(id)
	tasks.task_done(id)

func _on_food_mistake():
	mistake.emit()

func _on_water_mistake():
	mistake.emit()

func _on_torches_mistake():
	mistake.emit()

func _on_mistakes_mistake():
	mistake.emit()

func set_mistake_true(mistakes_made):
	if mistakes_made > 0:
		mistakes.set_mistake_true(mistakes_made)

func reset():
	food_bar.reset()
	water_bar.reset()
	torches.reset()
	mistakes.reset()
	tasks.reset()
