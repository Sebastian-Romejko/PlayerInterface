extends Control

signal start_game()

func _on_button_button_down():
	start_game.emit()