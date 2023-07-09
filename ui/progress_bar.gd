extends TextureProgressBar

@onready var label = $Label
@onready var timer = $Timer

signal condition_fulfilled(id)
signal mistake()

var can_scroll = false
var conditions = {}
var conditions_values = {}
var value_backup: int = 100

func _on_mouse_entered():
	can_scroll = true
	set_default_cursor_shape(CursorShape.CURSOR_HSIZE)

func _on_mouse_exited():
	can_scroll = false

func _on_ready():
	value_backup = value

func _input(event):
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if can_scroll:
			var start_value = value
			if Input.is_action_just_released("mouse_scroll_up"):
				value += 1
			elif Input.is_action_just_released("mouse_scroll_down"):
				value -= 1
				
			label.text = str(value)
			if start_value != value:
				timer.start(1)

func set_condition(value, id):
	var requested_value = self.value + value
	if (self.value == 100 && value > 0) \
		|| (self.value == 0 && value < 0):
		condition_fulfilled.emit(id)
	elif requested_value >= 100:
		conditions[id] = 100
	elif requested_value <= 0:
		conditions[id] = 0
	else:
		conditions[id] = requested_value
	conditions_values[id] = value

func _on_timer_timeout():
	if conditions.is_empty():
		value = value_backup
		label.text = str(value)
		mistake.emit()
		return

	var condition_id_done
	for condition_id in conditions.keys():
		if value - conditions[condition_id] < 5 \
			&& value - conditions[condition_id] > -5:
			value = conditions[condition_id]
			label.text = str(value)
			condition_fulfilled.emit(condition_id)
			condition_id_done = condition_id
			value_backup = value 
			break
		else:
			value = value_backup
			label.text = str(value)
			mistake.emit()
			break
	if condition_id_done != null:
		value = conditions[condition_id_done]
		conditions.erase(condition_id_done)
		conditions_values.erase(condition_id_done)
		recalculate_conditions()

func recalculate_conditions():
	var conditions_ids_done = []
	for condition_id in conditions_values.keys():
		var requested_value = self.value + conditions_values[condition_id]
		if (self.value == 100 && value > 0) \
			|| (self.value == 0 && value < 0):
			condition_fulfilled.emit(condition_id)
			conditions_ids_done.append(condition_id)
		elif requested_value >= 100:
			conditions[condition_id] = 100
		elif requested_value <= 0:
			conditions[condition_id] = 0
		else:
			conditions[condition_id] = requested_value
	for condition_id_to_remove in conditions_ids_done:
		conditions.erase(condition_id_to_remove)
		conditions_values.erase(condition_id_to_remove)

func reset():
	value = 100
	label.text = str(value)
	conditions = {}
	conditions_values = {}
	can_scroll = false
	value_backup = 100


func _on_static_body_2d_input_event():
	pass
