extends BoxContainer

signal condition_fulfilled(id)
signal mistake()

@onready var mistake1 = $mistake1
@onready var mistake2 = $mistake2
@onready var mistake3 = $mistake3

var mistakes = {}
var conditions = {}
var mistake_made = false

func _ready():
	mistakes = {
		1: mistake1.value,
		2: mistake2.value,
		3: mistake3.value,
	}

func set_condition(id):
	print("NEW CONDITION: %s %s" % [id, get_first_negative_mistake()])
	conditions[id] = get_first_negative_mistake()

func _on_mistake_1_value_changed(value):
	mistakes[1] = value
	check_condition()
	if mistake_made:
		mistakes[1] = 1 if mistakes[1] == 0 else 0
		mistake1.set_value(mistakes[1])
		mistake_made = false
		mistake.emit()

func _on_mistake_2_value_changed(value):
	mistakes[2] = value
	check_condition()
	if mistake_made:
		mistakes[2] = 1 if mistakes[2] == 0 else 0
		mistake2.set_value(mistakes[2])
		mistake_made = false
		mistake.emit()

func _on_mistake_3_value_changed(value):
	mistakes[3] = value
	check_condition()
	if mistake_made:
		mistakes[3] = 1 if mistakes[3] == 0 else 0
		mistake3.set_value(mistakes[3])
		mistake_made = false
		mistake.emit()

func check_condition():
	if conditions.is_empty() || get_first_negative_mistake() == 0:
		mistake_made = true
		return

	var condition_id_done
	for condition_id in conditions.keys():
		if get_first_negative_mistake() - 1 == conditions[condition_id] \
			&& is_order_correct():
			print("GOOD")
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
		conditions[condition_id] = get_first_negative_mistake()

func get_first_negative_mistake():
	for i in range(1,mistakes.size() + 1,1):
		print("TEST: %s %s" % [i, mistakes[i]])
		if mistakes[i] == 0:
			return i
	return 0

func is_order_correct():
	for mistake_id in mistakes.keys():
		if mistakes[mistake_id] == 1 && mistake_id >= get_first_negative_mistake():
			return false
	return true
	
func set_last_mistake_true():
	mistake3.set_value(1)
	mistakes[3] = 1

func reset():
	mistake1.set_value(0)
	mistake2.set_value(0)
	mistake3.set_value(0)
	mistakes = {
		1: mistake1.value,
		2: mistake2.value,
		3: mistake3.value,
	}
	conditions = {}
	mistake_made = false