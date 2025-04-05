extends Node

@export var camera: Camera2D  # The camera this listens for

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		camera.toggle_camera_off()
	if event.is_action_pressed("ui_down"):
		camera.toggle_camera_off()
	if event.is_action_pressed("ui_left"):
		camera.toggle_camera_off()
	if event.is_action_pressed("ui_right"):
		camera.toggle_camera_off()
