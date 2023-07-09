extends Node2D

@onready var collectibles = $collectibles
@onready var character = $character
@onready var ui = $CanvasLayer/ui
@onready var game_over_panel = $CanvasLayer/game_over_panel
@onready var food_timer = $timers/food_timer
@onready var water_timer = $timers/water_timer
@onready var torch_timer = $timers/torch_timer

@export var food_lost = 10
@export var water_lost = 15

@export var seconds_for_task: float = 5

var next_condition_id = 0
var active_conditions = {}
var mistakes_made = 0

func _process(delta):
	var active_conditions_id_to_remove
	for id in active_conditions.keys():
		active_conditions[id] -= delta
		if active_conditions[id] <= 0:
			active_conditions_id_to_remove = id
			ui.set_mistake_true(mistakes_made)
			mistakes_made += 1
			if mistakes_made >= 3:
				game_over_panel.visible = true
				game_over_panel.set_time()
			break

	active_conditions.erase(active_conditions_id_to_remove)

func _on_food_timer_timeout():
	add_new_condition()
	ui.change_food_value(-food_lost, next_condition_id, seconds_for_task)
	
func _on_water_timer_timeout():
	add_new_condition()
	ui.change_water_value(-water_lost, next_condition_id, seconds_for_task)
	
func _on_torch_timer_timeout():
	add_new_condition()
	ui.lose_torch(next_condition_id, seconds_for_task)

func _on_collectibles_food_change(value):
	add_new_condition()
	ui.change_food_value(value, next_condition_id, seconds_for_task)

func _on_collectibles_water_change(value):
	add_new_condition()
	ui.change_water_value(value, next_condition_id, seconds_for_task)

func _on_collectibles_torch_gained():
	add_new_condition()
	ui.gain_torch(next_condition_id, seconds_for_task)

func _on_ui_condition_fulfilled(id):
	active_conditions.erase(id)

func _on_ui_mistake():
	mistakes_made += 1
	if mistakes_made >= 3:
		ui.set_mistake_true(1)
		ui.set_mistake_true(2)
		ui.set_mistake_true(3)
		game_over_panel.visible = true
		game_over_panel.set_time()
	else:
		add_new_condition()
		ui.add_mistake(next_condition_id, seconds_for_task)

func add_new_condition():
	next_condition_id += 1
	active_conditions[next_condition_id] = seconds_for_task

func _on_game_over_panel_start_again():
	mistakes_made = 0
	next_condition_id = 0
	active_conditions = {}
	ui.reset()
	character._init()
	collectibles.clear()
	collectibles.spawn_collectibles()
	food_timer.start()
	water_timer.start()
	torch_timer.start()
	Global.time_survived = 0
	game_over_panel.visible = false