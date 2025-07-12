extends Node



@export var base_item: ItemData = preload("res://resource/item_data.tres")

func produce_item(duck: CharacterBody2D) -> ItemData:
	var item_instance: ItemData = base_item.duplicate()
	
	var local_bonus = 0
	
	var character_bonus = duck.get_gathering_modifier()
	
	var global_bonus = GameData.get_global_modifier("gathering")
	
	item_instance.amount = item_instance.amount + 10
	item_instance.name = "food"
	
	return item_instance
