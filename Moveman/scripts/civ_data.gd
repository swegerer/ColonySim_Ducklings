extends RefCounted
class_name CivData

var max_value: int = 4
var current_value: int = 0

func _init(max: int = 0, value: int = 0):
	max_value = max
	set_value(value)

func set_value(value: int): 
	current_value = clamp(value, 0, max_value)

func set_max(value: int):
	max_value = value
	current_value = clamp(current_value, 0, max_value)
