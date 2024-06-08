extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func _process(_delta):
	if Input.is_action_just_pressed("pause_menu") and get_tree().paused:
		_resume()
	
	elif Input.is_action_just_pressed("pause_menu") and not get_tree().paused:
		_pause()


func _pause():
	get_tree().paused = true
	$AnimationPlayer.play("appear")
	%Resume.grab_focus()
	
func _resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("appear")
	
func _quit():
	pass
	
func _options():
	pass
	

func _on_resume_pressed():
	_resume()


func _on_restart_pressed():
	get_tree().reload_current_scene()
	_resume()


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	pass # Replace with function body.
