extends MarginContainer

@export var close_button: TextureButton

var current_location: Node
var ITEM_SLOT_PATH = "res://scenes/item_slot.tscn"
var hbox_inventory: HBoxContainer 

@export var inventory_display: Node
signal closed

# In duck_window.gd
func _ready():
	update_size()
	get_viewport().connect("size_changed", Callable(self, "update_size"))
	close_button.pressed.connect(_on_close_pressed)

func _on_close_pressed():
	current_location.inventory.inventory_changed.disconnect(_on_inventory_changed)
	emit_signal("closed")
	queue_free()


func update_size():
	var viewport_size = get_viewport().get_visible_rect().size
	var target_width = viewport_size.x * 0.6  # 60% of screen width
	custom_minimum_size = Vector2(target_width, 0)  # height can be handled by layout

func _on_inventory_changed():
	print("ON LOCATION INVENTORY CHANGED _----------------")
	inventory_display.display_update(current_location.inventory)

func set_location(location: Node) -> void:
	
		
	current_location = location
	current_location.inventory.inventory_changed.connect(_on_inventory_changed)
	#draw_inventory()
	#update_ui_with_duck_info()
	
	
#func draw_inventory() -> void:
	#var item_canvas = load(ITEM_SLOT_PATH).instantiate()
	
	#var item = current_duck.inventory.get_inventar(0)
	
	#item_canvas.set_item_data(item)
	#item.icon = preload("res://sprites/camera_on.png")
	
	
	#item.icon =  preload("res://sprites/camera_on.png") 
	# Could be placed more effectivly
	#hbox_inventory = get_node("Panel/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer2")
	
	#hbox_inventory.add_child(item_canvas)
	
