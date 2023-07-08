extends Node2D

@onready var ui = $CanvasLayer/ui

@export var seconds_for_task: float = 5

var next_condition_id = 1
var active_conditions = {}

func _process(delta):
	for id in active_conditions.keys():
		active_conditions[id] -= delta
		if active_conditions[id] <= 0:
			print("GAME OVER")
			queue_free()

func _on_collectibles_food_change(value):
	ui.change_food_value(value, next_condition_id)
	active_conditions[next_condition_id] = seconds_for_task
	print("New condition: " + str(next_condition_id))
	next_condition_id += 1

func _on_collectibles_water_change(value):
	ui.change_water_value(value, next_condition_id)
	active_conditions[next_condition_id] = seconds_for_task
	print("New condition: " + str(next_condition_id))
	next_condition_id += 1

func _on_ui_condition_fulfilled(id):
	active_conditions.erase(id)
	print("Condition fulfilled: " + str(id))

func _on_ui_mistake():
	print("GAME OVER")
	queue_free()