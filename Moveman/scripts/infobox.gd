extends Node2D

@export var character: Node2D
@export var name_field: Label
@export var location_list: RichTextLabel

func _ready():
	character.update_data.connect(refresh_info)

func refresh_info():
	name_field.text = character.name
	# Update labels & text here
	location_list.clear()
	for loc in character.known_locations:
		location_list.append_text(str(loc.position))
