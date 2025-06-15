extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	# Update panel size every frame (you can optimize this later)
	var min_size = Vector2.ZERO
	for child in get_children():
		if child is Control:
			var child_end = child.position + child.size
			min_size.x = max(min_size.x, child_end.x)
			min_size.y = max(min_size.y, child_end.y)
	size = min_size
