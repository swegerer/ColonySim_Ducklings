extends Node
class_name Inventory

@export var size: int = 10

# Interne Liste zur Verwaltung der Items
var items: Array[ItemData] = []

# Gibt das Item am Index zurück (oder null)
func get_inventar(index: int) -> ItemData:
	if index >= 0 and index < items.size():
		return items[index]
	return null

# Fügt ein Item hinzu. Gibt true zurück, wenn erfolgreich.
func add(item: ItemData) -> bool:
	if items.size() < size:
		items.append(item.duplicate())  # duplizieren für Sicherheit
		return true
	else:
		print("Inventory full")
		return false

# Entfernt das Item am gegebenen Index.
func remove(index: int) -> ItemData:
	if index >= 0 and index < items.size():
		var ret = items[index].duplicate()
		items.remove_at(index)
		return ret
	return null
	
func is_empty() -> bool:
	if items.size() > 0:
		return true
	else:
		return false
