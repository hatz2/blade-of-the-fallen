extends Node2D

@export var text: String
@export var move := true

var move_dir := Vector2.UP
var speed := 100
var friction := 15

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if move:
		global_position += speed * move_dir * delta
		speed = max(speed - friction * delta, 0)
		
		
func update_pivot():
	$Label.pivot_offset = $Label.size / 2
