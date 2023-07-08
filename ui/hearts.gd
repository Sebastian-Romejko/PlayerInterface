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

func _ready():
	hearts = {
		1: heart1.value,
		2: heart2.value,
		3: heart3.value,
		4: heart4.value,
		5: heart5.value,
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
	for i in range(0,hearts.size(),-1):
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
		&& is_order_currect():
		condition_heart_id = 0
		condition_value = null
		condition_fulfilled.emit()

func is_order_currect():
	for heart in hearts:
		if heart.key > condition_heart_id && heart.value == 1:
			return false
	return true