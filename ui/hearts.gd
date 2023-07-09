extends HBoxContainer

signal condition_fulfilled()

@onready var heart1 = $heart1
@onready var heart2 = $heart2
@onready var heart3 = $heart3
@onready var heart4 = $heart4
@onready var heart5 = $heart5

var condition_heart_id
var condition_value
var hearts = {}
var conditions = {}
var mistake_made = false

func _ready():
	hearts = {
		1: 1,
		2: 1,
		3: 1,
		4: 1,
		5: 1,
	}

func set_condition(value):
	if value == -1:
		condition_heart_id = get_last_positive_heart()
		condition_value = 0
	elif value == 1:
		condition_heart_id = get_first_negative_heart()
		condition_value = 1

func get_last_positive_heart():
	for i in range(hearts.size(),0,-1):
		if hearts[i] == 1:
			return i
	return 0

func get_first_negative_heart():
	for i in range(0,hearts.size(),1):
		if hearts[i] == 0:
			return i
	return 0

func _on_heart_1_value_changed(value):
	hearts[1] = value
	check_condition()

func _on_heart_2_value_changed(value):
	hearts[2] = value
	check_condition()

func _on_heart_3_value_changed(value):
	hearts[3] = value
	check_condition()
	
func _on_heart_4_value_changed(value):
	hearts[4] = value
	check_condition()

func _on_heart_5_value_changed(value):
	hearts[5] = value
	check_condition()

func check_condition():
	if condition_heart_id != 0 \
		&& hearts[condition_heart_id] == condition_value \
		&& is_order_correct():
		condition_heart_id = 0
		condition_value = null
		condition_fulfilled.emit()

func is_order_correct():
	for heart in hearts:
		if heart.key > condition_heart_id && heart.value == 1:
			return false
	return true

func reset():
	heart1.set_value(1)
	heart2.set_value(1)
	heart3.set_value(1)
	heart4.set_value(1)
	heart5.set_value(1)
	hearts = {
		1: 1,
		2: 1,
		3: 1,
		4: 1,
		5: 1,
	}
	conditions = {}
	mistake_made = false
