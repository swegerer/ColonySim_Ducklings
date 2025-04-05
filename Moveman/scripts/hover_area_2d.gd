extends Area2D

signal hovered(hover_area)
signal unhovered(hover_area)
signal clicked(hover_area)

@export var hover_info: String = "Default Info"
@export var hover_type: String = "character"  # Can be "character", "location", etc.


@onready var collision_shape = $CollisionShape2D

@export var shape_size: Vector2 = Vector2(10, 10)  # Default size

func _ready():
	if collision_shape and collision_shape.shape is RectangleShape2D:
		collision_shape.shape.extents = shape_size / 2  # Set correct size
	connect("mouse_entered", _on_mouse_enter)
	connect("mouse_exited", _on_mouse_exit)
	connect("input_event", _on_input_event)

func _on_mouse_enter():
	emit_signal("hovered", self)

func _on_mouse_exit():
	emit_signal("unhovered", self)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked", self)
