extends Control

var data_manager  # Reference to DataController

@export var icon: TextureRect
@export var label: Label

func _ready():
	# Delay execution to ensure the full tree is ready
	print("")


func resource_update(resource_name, resource):
	print("hahahlloo")
	label.text = "0 / 10"
