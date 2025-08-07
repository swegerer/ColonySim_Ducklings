extends Control

@export var columns: int = 5
@onready var grid: GridContainer = $ScrollContainer/GridContainer

var size_display: int

var tex = preload("res://sprites/food_01.png")

func _ready():
	size_display = 10
	grid.columns = columns
	display_init()
	update_slot_size()

func update_slot_size():
	var total_width = grid.size.x
	var spacing = grid.get_theme_constant("h_separation")
	var slot_width = (total_width - spacing * (columns - 1)) / columns

	for child in grid.get_children():
		child.custom_minimum_size = Vector2(slot_width, slot_width)  # quadratisch


func display_init() -> void:
	for child in grid.get_children():
		child.queue_free()
		
	for item_data in size_display:
		var slot = preload("res://scenes/item_slot.tscn").instantiate()
		print("sdjflksdfjlksdflksdjf")
		
		var base_item: ItemData = preload("res://resource/item_data.tres")
		var item_instance: ItemData = base_item.duplicate()

		item_instance.amount = item_instance.amount + 10
		item_instance.name = "food"
		item_instance.icon = tex.get_image()
		
		slot.set_item_data(item_instance)
		
		grid.add_child(slot)
	update_slot_size()  # Nachträglich Slot-Größen anpassen
