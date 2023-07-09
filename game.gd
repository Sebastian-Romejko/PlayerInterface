extends Node2D

@onready var collectibles = $collectibles
@onready var character = $character
@onready var ui = $CanvasLayer/ui
@onready var game_over_panel = $CanvasLayer/game_over_panel

@export var food_lost = 10
@export var water_lost = 15

@export var seconds_for_task: float = 5

var next_condition_id = 0
var active_conditions = {}
var mistakes_made = 0

func _process(delta):
	for id in active_conditions.keys():
		active_conditions[id] -= delta
		if active_conditions[id] <= 0:
			make_mistake()

func _on_food_timer_timeout():
	add_new_condition()
	ui.change_food_value(-food_lost, next_condition_id, seconds_for_task)
	
func _on_water_timer_timeout():
	add_new_condition()
	ui.change_water_value(-water_lost, next_condition_id, seconds_for_task)
	
func _on_torch_timer_timeout():
	pass
	#add_new_condition()
	# TODO: Remove torch 

func _on_collectibles_food_change(value):
	add_new_condition()
	ui.change_food_value(value, next_condition_id, seconds_for_task)

func _on_collectibles_water_change(value):
	add_new_condition()
	ui.change_water_value(value, next_condition_id, seconds_for_task)

func _on_collectibles_torch_gained():
	pass
	#add_new_condition()
	# TODO: Add torch

func _on_ui_condition_fulfilled(id):
	print("Condition fulfilled: " + str(id))
	active_conditions.erase(id)

func _on_ui_mistake():
	make_mistake()

func add_new_condition():
	next_condition_id += 1
	active_conditions[next_condition_id] = seconds_for_task

func make_mistake():
	mistakes_made += 1
	if mistakes_made >= 3:
		print("GAME OVER")
		game_over_panel.visible = true
		game_over_panel.set_time()
	else:
		add_new_condition()
		ui.add_mistake(next_condition_id, seconds_for_task)

func _on_game_over_panel_start_again():
	mistakes_made = 0
	next_condition_id = 0
	active_conditions = {}
	ui.reset()
	character._init()
	collectibles.clear()
	collectibles.spawn_collectibles()
	Global.time_survived = 0
	game_over_panel.visible = false