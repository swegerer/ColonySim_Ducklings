extends Node

# Hier speichern wir die vorgehaltenen Instanzen pro Szene
var pools: Dictionary = {}
var initial_size := 5

func register_scene(scene_path: String, size: int = initial_size):
	if pools.has(scene_path):
		return # schon registriert

	var scene_res = ResourceLoader.load(scene_path)
	pools[scene_path] = {
		"scene": scene_res,
		"available": []
		}

	# Vorinitialisieren
	for i in range(size):
		var inst = scene_res.instantiate()
		_deactivate_entity(inst)
		add_child(inst)
		pools[scene_path]["available"].append(inst)

func get_entity(scene_path: String) -> Node:
	if !pools.has(scene_path):
		push_error("Scene not registered in pool: " + scene_path)
		return null

	var pool = pools[scene_path]
	var entity: Node

	if pool["available"].is_empty():
		entity = pool["scene"].instantiate()
		add_child(entity)
	else:
		entity = pool["available"].pop_back()
	
	_activate_entity(entity)
	return entity

func return_entity(scene_path: String, entity: Node):
	if !pools.has(scene_path):
		push_error("Scene not registered in pool: " + scene_path)
		return

	_deactivate_entity(entity)
	pools[scene_path]["available"].append(entity)

func _deactivate_entity(entity: Node):
	entity.visible = false
	entity.set_physics_process(false)
	entity.set_process(false)
	if entity.has_method("reset"):
		entity.reset() # optional: Zustand zurücksetzen

func _activate_entity(entity: Node):
	entity.visible = true
	entity.set_physics_process(true)
	entity.set_process(true)
