extends TextureProgressBar

var can_scroll = false

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