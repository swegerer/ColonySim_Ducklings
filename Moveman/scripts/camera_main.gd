extends Camera2D

# Speed for movement and zoom
var move_speed = 600
var zoom_speed = 1.5

# Initial zoom level
var zoom_level = 1.0

func _ready():
	# Set the initial zoom level
	zoom = Vector2(zoom_level, zoom_level)

func _process(delta):
	# Handle movement input (WASD)
	var movement = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):  # W
		movement.y -= 1
	if Input.is_action_pressed("ui_down"):  # S
		movement.y += 1
	if Input.is_action_pressed("ui_left"):  # A
		movement.x -= 1
	if Input.is_action_pressed("ui_right"):  # D
		movement.x += 1

	# Move the camera
	position += movement.normalized() * move_speed * delta

	# Handle zoom input (Comma and Period)
	if Input.is_action_just_pressed("zoom_in"):  # Comma
		zoom_level = max(0.2, zoom_level + zoom_speed * delta)
		if zoom_level > 2:
			zoom_level = 2
	if Input.is_action_just_pressed("zoom_out"):  # Period
		zoom_level = min(3.0, zoom_level - zoom_speed * delta)
		if zoom_level < 0.5:
			zoom_level = 0.5
		

	# Apply the zoom level
	zoom = Vector2(zoom_level, zoom_level)
