extends Control

var data_manager  # Reference to DataController

@export var image: Texture2D
@export var icon: TextureRect
@export var label: Label

func _ready():
	icon.texture = image  # just in case you want to update it too

func display_slot_update(resource_name, resource):
	label.text = str(resource.current_value)

