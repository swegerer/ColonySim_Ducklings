extends MarginContainer


func _ready():
	update_size()
	get_viewport().connect("size_changed", Callable(self, "update_size"))

func update_size():
	var viewport_size = get_viewport().get_visible_rect().size
	var target_width = viewport_size.x * 0.6  # 60% of screen width
	custom_minimum_size = Vector2(target_width, 0)  # height can be handled by layout
