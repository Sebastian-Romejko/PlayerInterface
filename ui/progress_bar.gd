extends TextureProgressBar

@onready var timer = $Timer

signal condition_fulfilled(id)
signal mistake()

var can_scroll = false
var conditions = {}

func _on_mouse_entered():
	can_scroll = true
	set_default_cursor_shape(CursorShape.CURSOR_HSIZE)

func _on_mouse_exited():
	can_scroll = false

func _input(event):
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if can_scroll:
			if Input.is_action_just_released("mouse_scroll_up"):
				value += 2
			elif Input.is_action_just_released("mouse_scroll_down"):
				value -= 2
				
		timer.start(1)

func set_condition(value, id):
	conditions[id] = max(min(self.value + value, 100), 0)

func _on_timer_timeout():
	var not_done_conditions = {}
	var any_condition_fulfilled = false
	for condition_id in conditions.keys():
		if value - conditions[condition_id] < 5 \
			|| value - conditions[condition_id] > -5:
			value = conditions[condition_id]
			condition_fulfilled.emit(condition_id)
			any_condition_fulfilled = true
		else:
			not_done_conditions[condition_id] = conditions[condition_id]
	conditions = not_done_conditions
	if !any_condition_fulfilled:
		mistake.emit()
