
class_name FoodSource
extends "res://scripts/location.gd"

@export var slot_manager: WorkerSlotManager

var worktime = 20

func _ready():
	slot_manager.redraw_slots()

func ask_entry(duck):
	slot_manager.request_slot(duck)


func get_worktime():
	return worktime
