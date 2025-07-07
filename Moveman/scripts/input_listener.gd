extends Node2D

@export var camera: Camera2D  # The camera this listens for

@export var canvas: CanvasLayer
var path = "res://scenes/sidewindow.tscn"



func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		camera.toggle_camera_off()
	if event.is_action_pressed("ui_down"):
		camera.toggle_camera_off()
	if event.is_action_pressed("ui_left"):
		camera.toggle_camera_off()
	if event.is_action_pressed("ui_right"):
		camera.toggle_camera_off()

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:		
		handle_double_click(get_global_mouse_position())
		
func handle_double_click(pos: Vector2):
	var space_state = get_world_2d().direct_space_state
	

	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	query.collide_with_bodies = false  # Or true if ducks are also bodies
	query.collision_mask = 0xFFFFFFFF

	var hits = space_state.intersect_point(query, 5)

	for hit in hits:
		var node = hit.collider
		while node:
			if node.is_in_group("ducks"):
				node.focus_camera_on(node)
				
				var new_scene = load(path).instantiate()
				canvas.add_child(new_scene)
				
				return
			node = node.get_parent()
