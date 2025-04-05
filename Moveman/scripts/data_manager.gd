extends Node

signal resource_updated(resource_name, resource)  # Signal for updates

var resources: Dictionary = {}  # Holds the data


func _ready():
		
	add_resource("food", 25, 10)
	add_resource("wood", 10, 0)
		
	#resource_updated.emit("food", resources["food"])

func notify_resource_data(p_name):
	print("EMITTING SIGNAL FROM INSTANCE:", self)
	
	resource_updated.emit(p_name, resources[p_name])  # Notify listeners
	get_tree().root.print_tree_pretty()

	
func change_value_on_resource(resource_name: String, value: int):
	if resource_name in resources:
		resources[resource_name].set_value(value)
		resource_updated.emit(resource_name, resources[resource_name])
		
func change_max_on_resource(resource_name: String, value: int):
	if resource_name in resources:
		resources[resource_name].set_max(value)
		resource_updated.emit(resource_name, resources[resource_name])
		print("MAX CHANGE EMIT SIGNAL")

func add_resource(p_name: String, p_max: int, p_value: int):
	if p_name not in resources:
		resources[p_name] = ResourceData.new(p_max, p_value)
		notify_resource_data(p_name)
