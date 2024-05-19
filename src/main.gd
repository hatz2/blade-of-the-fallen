extends Node

const WORLD_SCENE = preload("res://src/test_world/test_world.tscn")

func _ready():
	pass

func _on_main_menu_start_game():
	add_child(WORLD_SCENE.instantiate())
	$MainMenu.queue_free()
