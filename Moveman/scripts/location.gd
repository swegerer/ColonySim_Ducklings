extends Node



@export var base_item: ItemData = preload("res://resource/item_data.tres")
var tex = preload("res://sprites/food_01.png")

func produce_item(duck: CharacterBody2D) -> ItemData:
	var item_instance: ItemData = base_item.duplicate()
	
	var local_bonus = 0
	
	var character_bonus = duck.get_gathering_modifier()
	
	var global_bonus = GameData.get_global_modifier("gathering")
	
	item_instance.amount = item_instance.amount + 10
	item_instance.name = "food"
	item_instance.icon = tex.get_image()
	
	return item_instance


func get_hypertext() -> String:
	return "[b]%s[/b]" % [
		name
	]
