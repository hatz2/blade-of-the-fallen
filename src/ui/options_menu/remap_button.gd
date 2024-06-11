class_name RemapButton
extends Button

@export var action: String
@export var keycode: int
@export var test: InputEventKey

func _ready():
	toggle_mode = true
	set_process_unhandled_input(false)

func _toggled(toggled_on):
	set_process_unhandled_input(toggled_on)
	
	if toggled_on:
		text = "..."
		release_focus()
	else:
		grab_focus()
		
func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed():
		event = event as InputEventKey
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)
		button_pressed = false
		text = event.as_text()
		keycode = event.keycode
		

func set_key(key_code: int):
	keycode = key_code
	var key_event = InputEventKey.new()
	key_event.keycode = key_code
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, key_event)
	text = key_event.as_text()
