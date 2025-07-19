extends MarginContainer

@export var close_button: TextureButton

signal closed

# In duck_window.gd
func _ready():
	update_size()
	get_viewport().connect("size_changed", Callable(self, "update_size"))
	close_button.pressed.connect(_on_close_pressed)

func _on_close_pressed():
	emit_signal("closed")
	queue_free()



func update_size():
	var viewport_size = get_viewport().get_visible_rect().size
	var target_width = viewport_size.x * 0.6  # 60% of screen width
	custom_minimum_size = Vector2(target_width, 0)  # height can be handled by layout
