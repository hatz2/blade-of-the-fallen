extends Control

signal start_game()
signal options_pressed()

func _ready():
	%StartButton.grab_focus()

func _on_start_button_pressed():
	start_game.emit()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_options_button_pressed():
	options_pressed.emit()
