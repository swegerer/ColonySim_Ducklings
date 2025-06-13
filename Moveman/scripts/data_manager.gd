extends Node

signal resource_updated(resource_name, resource)  # Signal for updates
signal locations_updated(locations)

var resources: Dictionary = {}  # Holds the data

var discovered_locations: Array[Node] = []

func _ready():
	add_resource("food", 25, 25)
	add_resource("wood", 10, 0)
	
	notify_resource_data("food")
	#notify_resource_data("wood")
	#resource_updated.emit("food", resources["food"])

func notify_resource_data(p_name):
	print("EMITTING SIGNAL FROM INSTANCE:", self)
	
	resource_updated.emit(p_name, resources[p_name])  # Notify listeners

func new_location(location):
	if location not in discovered_locations:
		discovered_locations.append(location)
		locations_updated.emit(discovered_locations)

func set_value_on_resource(resource_name: String, value: int):
	if resource_name in resources:
		resources[resource_name].set_value(value)
		notify_resource_data(resource_name)

func change_max_on_resource(resource_name: String, value: int):
	if resource_name in resources:
		resources[resource_name].set_max(value)
		notify_resource_data(resource_name)
		print("MAX CHANGE EMIT SIGNAL")

func add_resource(p_name: String, p_max: int, p_value: int):
	if p_name not in resources:
		resources[p_name] = ResourceData.new(p_max, p_value)
		notify_resource_data(p_name)

func get_value_on_resource(resource_name: String):
	return resources[resource_name].get_value()
