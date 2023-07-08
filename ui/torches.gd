extends HBoxContainer

signal condition_fulfilled()

@onready var torch1 = $torch1
@onready var torch2 = $torch2
@onready var torch3 = $torch3
@onready var torch4 = $torch4
@onready var torch5 = $torch5
@onready var torch6 = $torch6
@onready var torch7 = $torch7

var condition
var torches = {}

func _ready():
	torches = {
		1: torch1.value,
		2: torch2.value,
		3: torch3.value,
		4: torch4.value,
		5: torch5.value,
		6: torch6.value,
		7: torch7.value,
	}

func _on_torch_1_value_changed(value):
	torches[1] = value
	check_condition()

func _on_torch_2_value_changed(value):
	torches[2] = value
	check_condition()

func _on_torch_3_value_changed(value):
	torches[3] = value
	check_condition()
	
func _on_torch_4_value_changed(value):
	torches[4] = value
	check_condition()

func _on_torch_5_value_changed(value):
	torches[5] = value
	check_condition()

func _on_torch_6_value_changed(value):
	torches[6] = value
	check_condition()

func _on_torch_7_value_changed(value):
	torches[7] = value
	check_condition()

func check_condition():
	if condition != null && torches[condition.id] == condition.value:
		condition_fulfilled.emit()
