extends "res://scripts/state.gd"

var timer = 0.0
var UNLOAD_TIME = 5

func enter():
	character.show_progress()
	character.stop_movement()

func update(delta):
	timer += delta
	
	character.update_progress(timer / UNLOAD_TIME * 100.0)
	
	if timer > UNLOAD_TIME:
		character.unload_to_base(location_node)
		character.hide_progress()
		state_machine.change_state("IdleState")  # or whatever
