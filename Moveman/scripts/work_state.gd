extends "res://scripts/state.gd"

var direction_timer = 0
var timer = 0
var direction = Vector2.ZERO

var work_speed_bonus = 1

var lokal_location_node
var lokal_character

func enter():
	super()
	lokal_location_node = location_node
	lokal_location_node.ask_entry(character)
	
	lokal_character = state_machine.character
	lokal_character.velocity = Vector2(0, 0)
	#state_machine.character.move_and_slide()
	
	character.show_progress()
	
	
func update(delta):
	
	timer += delta

	lokal_character.update_progress(timer / lokal_location_node.get_worktime() * 100.0)

	if timer >= lokal_location_node.get_worktime():
		lokal_character.hide_progress()
		state_machine.change_state("IdleState")  # oder HomewardsState etc.
	
	if timer > (lokal_location_node.get_worktime() * work_speed_bonus):
		timer = 0
		finish_work()
	
	
func finish_work():
	var item = lokal_location_node.produce_item(lokal_character)
	lokal_character.inventory.add(item.duplicate())
	#location_node.reduce_resource(item.amount)
	#location_node.slot_manager.release_slot(lokal_character)
	state_machine.change_state("HomewardsState")	
	

func exit():
	if lokal_location_node and lokal_location_node.slot_manager:
		lokal_location_node.slot_manager.release_slot(lokal_character)
