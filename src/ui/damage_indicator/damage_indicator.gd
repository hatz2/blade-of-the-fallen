class_name DamageIndicator
extends Node2D

@export var speed: int = 50
@export var friction: int = 15
@onready var label := $Label
var move_direction: Vector2 = Vector2.ZERO
var damage_number: int
var color: Color = Color(1.0, 1.0, 1.0, 1.0) # white

# Called when the node enters the scene tree for the first time.
func _ready():
	#label.pivot_offset = label.size / 2
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	label.text = str(damage_number)
	label.set("theme_override_colors/font_color", color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += speed * move_direction * delta
	speed = max(speed - friction * delta, 0)
