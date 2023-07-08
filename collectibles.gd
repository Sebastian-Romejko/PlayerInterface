extends Node2D

signal food_change(value)
signal water_change(value)
signal torch_gained()

const FOOD_PATH = "res://collectibles/food.tscn"
const WATER_PATH = "res://collectibles/water.tscn"
const TORCH_PATH = "res://collectibles/torch.tscn"

@export var min_x: int
@export var max_x: int
@export var min_y: int
@export var max_y: int

@export var food_count = 50
@export var water_count = 100
@export var torch_count = 60

@export var character: Node2D

func _ready():
	spawn_collectibles()

func spawn_collectibles():
	for i in range(food_count):
		var food_scene: PackedScene = load(FOOD_PATH)
		var food = food_scene.instantiate()
		food.name = "food" + str(i)
		food.set_position(Vector2(
			randf_range(min_x, max_x),
			randf_range(min_y, max_y)))
		food.gain_food.connect(_on_food_gain)
		add_child(food)

	for i in range(water_count):
		var water_scene: PackedScene = load(WATER_PATH)
		var water = water_scene.instantiate()
		water.name = "water" + str(i)
		water.set_position(Vector2(
			randf_range(min_x, max_x),
			randf_range(min_y, max_y)))
		water.gain_water.connect(_on_water_gain)
		add_child(water)
	
	for i in range(torch_count):
		var torch_scene: PackedScene = load(TORCH_PATH)
		var torch = torch_scene.instantiate()
		torch.name = "torch" + str(i)
		torch.set_position(Vector2(
			randf_range(min_x, max_x),
			randf_range(min_y, max_y)))
		torch.gain_torch.connect(_on_torch_gain)
		add_child(torch)

func _on_food_gain(value):
	print("FOOD TAKEN FOR: " + str(value))
	food_change.emit(value)

func _on_water_gain(value):
	print("WATER TAKEN FOR: " + str(value))
	water_change.emit(value)

func _on_torch_gain():
	print("TORCH TAKEN")
