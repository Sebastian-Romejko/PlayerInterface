extends CharacterBody2D

@export var move_speed : float = 30
@export var idle_time_from : float = 1
@export var idle_time_to : float = 2
@export var walk_time_from : float = 3
@export var walk_time_to : float = 5

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D

var last_changed_position: Vector2
var last_changed_position_timestamp: int

var move_direction : Vector2 = Vector2.ZERO

func _physics_process(_delta):
	if player_moving():
		last_changed_position_timestamp = Time.get_ticks_msec()
		last_changed_position = Vector2(round(position.x), round(position.y))
		
	if move_direction == Vector2.ZERO \
		|| player_not_moving_timeout():
		select_new_direction()
		
	velocity = move_direction * move_speed
	state_machine.travel("walk")
	set_sprite_direction()
	move_and_slide()

func player_moving():
	return Vector2(round(position.x), round(position.y)) != last_changed_position
	
func player_not_moving_timeout():
	return Time.get_ticks_msec() - last_changed_position_timestamp > 1000 \
	 && Vector2(round(position.x), round(position.y)) == last_changed_position

func select_new_direction():
	if randi_range(-1,1) > 0:
		move_direction = Vector2(
			randi_range(-1,1),
			0,
		)
	else:
		move_direction = Vector2(
			0,
			randi_range(-1,1),
		)

func set_sprite_direction():
	if move_direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func round(value):
	return float("%.2f" % value)
