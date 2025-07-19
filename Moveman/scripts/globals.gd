extends Node

var camera_duck: Node = null


var ducks: Array = []

func register_duck(duck):
	if duck not in ducks:
		ducks.append(duck)

func find_duck_by_id(id: String):
	for duck in ducks:
		if duck.get_meta("id") == id:
			return duck
	return null
