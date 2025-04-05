extends Button

@export var camera_on: Texture2D
@export var camera_off: Texture2D

@onready var camera_duck = get_tree().current_scene.find_child("CameraDuck", true, false)

var camera_icon = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_button_pressed)
	

func _on_button_pressed():
	
	camera_duck.follow(self.get_parent())
	camera_duck.toggle_camera()
	
func set_icon(state):
	if state:
		icon = camera_off
	else:
		icon = camera_on



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

