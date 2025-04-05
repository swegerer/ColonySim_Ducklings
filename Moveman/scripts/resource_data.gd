extends Resource
class_name ResourceData

@export var max_value: int = 100
@export var current_value: int = 50

# Ensure current value never exceeds max
func set_value(value: int): 
	current_value = clamp(value, 0, max_value)
	
func set_max(value: int):
	max_value = value

func _init(max: int, value: int):
	max_value = max
	current_value = value
