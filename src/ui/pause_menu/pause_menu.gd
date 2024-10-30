extends Control

signal options_pressed()

func _ready():
	$AnimationPlayer.play("RESET")
	

func _process(_delta):
	if Input.is_action_just_pressed("esc_menu") and get_tree().paused:
		_resume()
	
	elif Input.is_action_just_pressed("esc_menu") and not get_tree().paused:
		_pause()


func _pause():
	get_tree().paused = true
	$AnimationPlayer.play("appear")
	%Resume.grab_focus()
	
	
func _resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("appear")

func _on_resume_pressed():
	_resume()


func _on_restart_pressed():
	_resume()
	get_tree().reload_current_scene()
	

func _on_options_pressed():
	options_pressed.emit()


func _on_quit_pressed():
	get_tree().quit()
