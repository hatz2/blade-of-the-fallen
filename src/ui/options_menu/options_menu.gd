extends Control

signal go_back_menu()
static var SETTINGS_PATH := "user://options.cfg"
@onready var _resolution_button = %ResolutionButton
@onready var _window_mode_button = %WindowModeButton
@onready var _general_volume_slider = %GeneralVolumeSlider
@onready var _music_volume_slider = %MusicVolumeSlider
@onready var _effects_volume_slider = %EffectsVolumeSlider
@onready var _jump_button = %JumpButton
@onready var _move_left_button = %MoveLeftButton
@onready var _move_right_button = %MoveRightButton
@onready var _attack_button = %AttackButton


const SUPPORTED_RESOLUTIONS :Dictionary = {
	"1280x720": Vector2i(1280, 720),
	"1366x768": Vector2i(1366, 768),
	"1600x900": Vector2i(1600, 900),
	"1920x1080": Vector2i(1920, 1080),
	"2560x1440": Vector2i(2560, 1440),
	"3840x2160": Vector2i(3840, 2160),
}

enum WINDOW_MODE {
	FULL_SCREEN, 
	BORDERLESS_FULL_SCREEN, 
	BORDERLESS_WINDOW, 
	WINDOW,
}


func _ready():
	_init_resolution_list()
	_load_config()
	
	
func _init_resolution_list():
	for resolution in SUPPORTED_RESOLUTIONS:
		_resolution_button.add_item(resolution)
		
	_resolution_button.selected = 3
	

func _save_config():
	var config = ConfigFile.new()
	config.set_value("graphics", "resolution", _resolution_button.selected)
	config.set_value("graphics", "window_mode", _window_mode_button.selected)
	config.set_value("sound", "general_volume", _general_volume_slider.value)
	config.set_value("sound", "music_volume", _music_volume_slider.value)
	config.set_value("sound", "effects_volume", _effects_volume_slider.value)
	config.set_value("keybinds", "jump", _jump_button.keycode)
	config.set_value("keybinds", "move_left", _move_left_button.keycode)
	config.set_value("keybinds", "move_right", _move_right_button.keycode)
	config.set_value("keybinds", "attack", _attack_button.keycode)
	
	config.save(SETTINGS_PATH)
	
	
func _load_config():
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_PATH)
	
	if err != OK:
		print("Error loading options config file")
		return
		
	_resolution_button.selected = config.get_value("graphics", "resolution", 3)
	_window_mode_button.selected = config.get_value("graphics", "window_mode", 3)
	_general_volume_slider.value = config.get_value("sound", "general_volume", 1)
	_music_volume_slider.value = config.get_value("sound", "music_volume", 1)
	_effects_volume_slider.value = config.get_value("sound", "effects_volume", 1)
	
	_jump_button.set_key(config.get_value("keybinds", "jump", 4194320))
	_move_left_button.set_key(config.get_value("keybinds", "move_left", 4194319))
	_move_right_button.set_key(config.get_value("keybinds", "move_right", 4194321))
	_attack_button.set_key(config.get_value("keybinds", "attack", 70))
	
	_on_resolution_button_item_selected(_resolution_button.selected)
	_on_window_mode_button_item_selected(_window_mode_button.selected)
	
	
func _on_resolution_button_item_selected(index):
	DisplayServer.window_set_size(SUPPORTED_RESOLUTIONS.values()[index])


func _on_window_mode_button_item_selected(index):
	match index:
		WINDOW_MODE.FULL_SCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		WINDOW_MODE.BORDERLESS_FULL_SCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		WINDOW_MODE.BORDERLESS_WINDOW:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		WINDOW_MODE.WINDOW:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)


func _on_return_button_pressed():
	go_back_menu.emit()


func _on_tree_exited():
	_save_config()


func _on_general_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"), 
		linear_to_db(value))


func _on_music_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"), 
		linear_to_db(value))


func _on_effects_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"), 
		linear_to_db(value))
	
