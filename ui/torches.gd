extends BoxContainer

signal condition_fulfilled(id)
signal mistake()

@onready var torch1 = $torch1
@onready var torch2 = $torch2
@onready var torch3 = $torch3
@onready var torch4 = $torch4
@onready var torch5 = $torch5
@onready var torch6 = $torch6
@onready var torch7 = $torch7

var torches = {}
var conditions = {}
var conditions_values = {}
var mistake_made = false

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

func set_condition(value, id):
	if value == 0:
		var last_positive_torch = get_last_positive_torch()
		print(last_positive_torch)
		if last_positive_torch == 0:
			condition_fulfilled.emit(id)
		else:
			conditions[id] = last_positive_torch
			conditions_values[id] = value
	elif value == 1:
		var first_negative_torch = get_first_negative_torch()
		if first_negative_torch == 0:
			condition_fulfilled.emit(id)
		else:
			conditions[id] = get_first_negative_torch()
			conditions_values[id] = value

func _on_torch_1_value_changed(value):
	torches[1] = value
	check_condition()
	if mistake_made:
		torches[1] = 1 if torches[1] == 0 else 0
		torch1.set_value(torches[1])
		mistake_made = false
		mistake.emit()

func _on_torch_2_value_changed(value):
	torches[2] = value
	check_condition()
	if mistake_made:
		torches[2] = 1 if torches[2] == 0 else 0
		torch2.set_value(torches[2])
		mistake_made = false
		mistake.emit()

func _on_torch_3_value_changed(value):
	torches[3] = value
	check_condition()
	if mistake_made:
		torches[3] = 1 if torches[3] == 0 else 0
		torch3.set_value(torches[3])
		mistake_made = false
		mistake.emit()

func _on_torch_4_value_changed(value):
	torches[4] = value
	check_condition()
	if mistake_made:
		torches[4] = 1 if torches[4] == 0 else 0
		torch4.set_value(torches[4])
		mistake_made = false
		mistake.emit()

func _on_torch_5_value_changed(value):
	torches[5] = value
	check_condition()
	if mistake_made:
		torches[5] = 1 if torches[5] == 0 else 0
		torch5.set_value(torches[5])
		mistake_made = false
		mistake.emit()

func _on_torch_6_value_changed(value):
	torches[6] = value
	check_condition()
	if mistake_made:
		torches[6] = 1 if torches[6] == 0 else 0
		torch6.set_value(torches[6])
		mistake_made = false
		mistake.emit()

func _on_torch_7_value_changed(value):
	torches[7] = value
	check_condition()
	if mistake_made:
		torches[7] = 1 if torches[7] == 0 else 0
		torch7.set_value(torches[7])
		mistake_made = false
		mistake.emit()
		
func check_condition():
	if conditions.is_empty():
		mistake_made = true
		return

	var condition_id_done
	for condition_id in conditions.keys():
		if ((conditions_values[condition_id] == 0 \
			&& get_first_negative_torch() == conditions[condition_id]) \
			|| (conditions_values[condition_id] == 1 \
			&& get_last_positive_torch() == conditions[condition_id])) \
			&& is_order_correct():
			condition_id_done = condition_id
			condition_fulfilled.emit(condition_id)
		else:
			mistake_made = true
			break
	if condition_id_done != null:
		conditions.erase(condition_id_done)
		recalculate_conditions()

func recalculate_conditions():
	for condition_id in conditions.keys():
		conditions[condition_id] = get_last_positive_torch()

func get_first_negative_torch():
	for i in range(1, torches.size() + 1,1):
		if torches[i] == 0:
			return i
	return 0

func get_last_positive_torch():
	for i in range(torches.size(), 0,-1):
		if torches[i] == 1:
			return i
	return 0

func is_order_correct():
	for torch_id in torches.keys():
		if torches[torch_id] == 1 && torch_id > get_last_positive_torch():
			return false
	return true

func reset():
	torch1.set_value(1)
	torch2.set_value(1)
	torch3.set_value(1)
	torch4.set_value(1)
	torch5.set_value(1)
	torch6.set_value(1)
	torch7.set_value(1)
	torches = {
		1: torch1.value,
		2: torch2.value,
		3: torch3.value,
		4: torch4.value,
		5: torch5.value,
		6: torch6.value,
		7: torch7.value,
	}
	conditions = {}
