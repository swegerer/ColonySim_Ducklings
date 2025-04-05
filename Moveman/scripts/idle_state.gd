extends "res://scripts/State.gd"

func enter():
	super()
	print("Entering Idle State")

func update(delta):
	#After 2 seconds, switch to search state
	if randf() < 0.01:
		state_machine.change_state("SearchState")
		

func on_collision():
	print("Collided! Picking new direction.")

