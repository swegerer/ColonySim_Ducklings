extends Camera2D



@onready var camera_main = get_tree().current_scene.find_child("CameraMain", true, false)

var current_target: Node = null

var camera_active = false

func follow(target: Node):
	if get_parent():
		get_parent().remove_child(self)
	target.add_child(self)  # Attach to the new NPC

	current_target = target
	global_position = target.global_position  # Instantly match position
	
func set_sideview():
	var screen_size = get_viewport().get_visible_rect().size
	offset = Vector2(screen_size.x * 0.3, 0)

func toggle_camera():
	var button = get_node("../ButtonCamera")
	button.set_icon(true)
	
	# Wonderful
	get_node("..").u_lock_ui()
	
	if !camera_active:
		enabled = true
		make_current()  # Switch camera
		camera_active = true
	else:
		toggle_camera_off()
	
func toggle_camera_off():
	if camera_active:
		var button = get_node("../ButtonCamera")
		button.set_icon(false)
	
		camera_main.position = global_position
		camera_main.enabled = true
		camera_main.make_current()
		camera_active = false


		
func _exit_tree():
	if has_node("../ButtonCamera"):
		var button = get_node("../ButtonCamera")
		button.set_icon(false)

