extends Node2D

class_name WorkerSlotManager

var slot_scene = preload("res://scenes/slot_worker.tscn")
@export var max_slots := 3

@export var hbox: HBoxContainer

var slots := []      # UI-Repräsentationen
var occupants := []  # Ducks, die gerade arbeiten
var waiting_queue := [] # Ducks in der Warteschlange

@export var empty_slot_image: Texture
@export var full_slot_image: Texture

func _ready():
	redraw_slots()

func redraw_slots():
	# Entferne alte Slots
	for s in slots:
		s.queue_free()
	slots.clear()
	occupants.clear()

	# Neue Slots erzeugen
	for i in max_slots:
		var slot = slot_scene.instantiate()
		hbox.add_child(slot)
		slots.append(slot)
		occupants.append(null)

func request_slot(duck):
	print("----------request_slot")
	
	for i in occupants.size():
		print("Occupant type at slot ", i, ": ", typeof(occupants[i]), " – Incoming duck type: ", typeof(duck))

		if occupants[i] == null:
			occupants[i] = duck
			print("Duck assigned to slot ", i)
			update_ui()
			return i  # Slot index

	# Kein freier Slot: enqueue
	waiting_queue.append(duck)
	print("No free slot, duck queued. Queue length: ", waiting_queue.size())
	return -1

func release_slot(duck):
	var index = occupants.find(duck)
	if index != -1:
		occupants[index] = null
		print("Duck released from slot ", index)
		if waiting_queue.size() > 0:
			var next_duck = waiting_queue.pop_front()
			occupants[index] = next_duck
			print("Next duck assigned from queue to slot ", index)
		update_ui()

func update_ui():
	for i in slots.size():
		if occupants[i] != null:
			slots[i].set_texture_normal(full_slot_image)
		else:
			slots[i].set_texture_normal(empty_slot_image)
		

