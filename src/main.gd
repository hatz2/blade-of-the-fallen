extends Node

const WORLD_SCENE = preload("res://src/test_world/test_world.tscn")
@onready var current_level: BaseLevel = null

var options_menu_caller = null

func _ready():
	_player_enabled(false)
	Globals.background_music_sound_player.stream = preload("res://assets/sounds/music-loop-bundle-download_2024/Stream Loops 2024-03-30_02.ogg")
	Globals.background_music_sound_player.play()

func _on_main_menu_start_game():
	# Add the first level scene
	Globals.background_music_sound_player.stop()
	Globals.background_music_sound_player.stream = preload("res://assets/sounds/music-loop-bundle-download_2024/Stream Loops 2024-05-01_01.ogg")
	Globals.background_music_sound_player.play()
	change_level("res://src/levels/initial_map/initial_map.tscn")
	
	
	
func change_level(level_path: String):
	# Make player not move
	PlayerInstance.set_physics_process(false)
		
	# Start animation transition
	$ChangeLevelCanvas/AnimationPlayer.play("in")
	await $ChangeLevelCanvas/AnimationPlayer.animation_finished
	
	# Delete current scene
	if current_level:
		current_level.queue_free()
		
	if %MainMenu.visible:
		%MainMenu.visible = false
		$GameUILayer.visible = true
		
	# Add new scene
	var new_level = load(level_path).instantiate()
	add_child(new_level)
	current_level = new_level
	current_level.change_level.connect(change_level)
	current_level.visible = true
	
	# Finish animation transition
	$ChangeLevelCanvas/AnimationPlayer.play("out")
	
	# Make player move
	_player_enabled(true)
	
	await $ChangeLevelCanvas/AnimationPlayer.animation_finished
	
func _player_enabled(enabled: bool):
	PlayerInstance.set_physics_process(enabled)
	PlayerInstance.get_node("Camera2D").enabled = enabled
	PlayerInstance.visible = enabled


func _on_main_menu_options_pressed():
	# Hide the main menu
	options_menu_caller = $MainUILayer/MainMenu/VBoxContainer
	$MainUILayer/MainMenu/VBoxContainer.hide()
	# Open the options menu
	%OptionsMenu.show()


func _on_options_menu_go_back_menu():
	%OptionsMenu.hide()
	$GameUILayer/PauseMenu.set_process(true)
	options_menu_caller.show()


func _on_pause_menu_options_pressed():
	options_menu_caller = $GameUILayer/PauseMenu
	$GameUILayer/PauseMenu.hide()
	$GameUILayer/PauseMenu.set_process(false)
	%OptionsMenu.show()
