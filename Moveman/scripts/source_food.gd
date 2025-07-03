
class_name FoodSource
extends "res://scripts/Location.gd"

@export var slot_manager: WorkerSlotManager

func _ready():
	slot_manager.redraw_slots()

func ask_entry(duck):
	slot_manager.request_slot(duck)







