extends Control

@export var columns: int = 5
@onready var grid: GridContainer = $ScrollContainer/GridContainer

var size_display: int

var tex = preload("res://sprites/food_01.png")

func _ready():
	size_display = 30
	grid.columns = columns
	display_init()
	update_slot_size()

func update_slot_size():
	var total_width = grid.size.x
	var spacing = grid.get_theme_constant("h_separation")
	var slot_width = (total_width - spacing * (columns - 1)) / columns

	for child in grid.get_children():
		child.custom_minimum_size = Vector2(slot_width, slot_width)  # quadratisch

var slot
var base_item: ItemData
var item_instance: ItemData

func display_init() -> void:
	#for child in grid.get_children():
	#	child.queue_free()
		
	for item_data in size_display:
		slot = preload("res://scenes/item_slot.tscn").instantiate()

		base_item = preload("res://resource/item_data.tres")
		item_instance = base_item.duplicate()

		#item_instance.amount = item_instance.amount + 10
		#item_instance.name = "food"
		#item_instance.icon = tex.get_image()
		
		slot.set_item_data(item_instance)
		
		grid.add_child(slot)
	update_slot_size()  # Nachträglich Slot-Größen anpassen

func display_update(inventory) -> void:
	var total_slots = inventory.size # oder eine feste Anzahl, falls gewünscht
	var item_count = inventory.items.size()

	# Erst alle vorhandenen Slots löschen (falls du kein echtes Reuse-System willst)
	for child in grid.get_children():
		child.queue_free()

	# Dann für jeden Slot index prüfen:
	for i in range(total_slots):
		var slot = preload("res://scenes/item_slot.tscn").instantiate()
		var base_item = preload("res://resource/item_data.tres")
		var item_instance = base_item.duplicate()
		
		if i < item_count:
			# Mit Inventar-Daten befüllen
			var src_item = inventory.items[i]
			item_instance.amount = src_item.amount
			item_instance.name = src_item.name
			item_instance.icon = src_item.icon
		else:
			# Leerer Slot (ItemData bleibt Standard)
			item_instance.amount = 0
			item_instance.name = ""
			item_instance.icon = null

		slot.set_item_data(item_instance)
		grid.add_child(slot)

	update_slot_size()
