extends HBoxContainer

signal condition_fulfilled()

@onready var heart1 = $heart1
@onready var heart2 = $heart2
@onready var heart3 = $heart3
@onready var heart4 = $heart4
@onready var heart5 = $heart5

var condition
var hearts = {}

func _ready():
	hearts = {
		1: heart1.value,
		2: heart2.value,
		3: heart3.value,
		4: heart4.value,
		5: heart5.value,
	}

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
	if condition != null && hearts[condition.id] == condition.value:
		condition_fulfilled.emit()
