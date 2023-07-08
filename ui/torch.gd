extends TextureRect

signal value_changed(value)

@export var id: int
@export var unchecked: Texture
@export var checked: Texture

var value = 1;
var can_be_clicked = false

func _on_mouse_entered():
	can_be_clicked = true
	set_default_cursor_shape(CursorShape.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	can_be_clicked = false

func _input(event):
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT && mouse_event.pressed && can_be_clicked:
			if value == 1:
				value = 0
				texture = unchecked
			else:
				value = 1
				texture = checked
			value_changed.emit(value)