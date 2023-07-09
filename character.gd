extends CharacterBody2D

@export var starting_position: Vector2

@export var move_speed : float = 2000
@export var idle_time_from : float = 1
@export var idle_time_to : float = 2
@export var walk_time_from : float = 3
@export var walk_time_to : float = 5
@export var max_range: float = 200
@export var waiting_time: float = 500
@export var collectibles: Node2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D

var last_changed_position: Vector2
var last_changed_position_timestamp: int

var move_direction : Vector2 = Vector2.ZERO
var nearest_collectible

func _init():
	position = starting_position
	last_changed_position = position
	last_changed_position_timestamp = Time.get_ticks_msec()

func _physics_process(delta):
	if move_direction == Vector2.ZERO \
		|| nearest_collectible == null:
		nearest_collectible = get_nearest_collectible()
	
	velocity = (nearest_collectible.position - position).normalized() * delta * move_speed
	state_machine.travel("walk")
	set_sprite_direction()
	move_and_slide()

func select_new_direction():
	if any_collectible_in_range():
		return get_nearest_collectible().position

	if randi_range(-1, 1) > 0:
		return position + Vector2(
			randi_range(-50, 50),
			0,
		)
	else:
		return position + Vector2(
			0,
			randi_range(-50, 50),
		)

func any_collectible_in_range():
	for collectible in collectibles.get_children():
		if position.distance_to(collectible.position) < max_range:
			return true

func get_nearest_collectible():
	var result
	for collectible in collectibles.get_children():
		#if position.distance_to(collectible.position) < max_range:
		if result == null \
			|| position.distance_to(collectible.position) < position.distance_to(result.position):
			result = collectible
	return result

func set_sprite_direction():
	if velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func round(value):
	return float("%.2f" % value)
