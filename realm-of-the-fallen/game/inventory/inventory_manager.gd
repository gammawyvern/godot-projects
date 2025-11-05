extends Node

signal inventory_changed

var inventory_data: InventoryData = null

func load_inventory_data(new_inventory_data: InventoryData) -> void:
	inventory_data = new_inventory_data
	emit_signal("inventory_changed")

func add_item(item_resource: InventoryItem) -> bool:
	if not item_resource:
		return false
	
	for slot_i in range(inventory_data.slots.size()):
		if not inventory_data.slots[slot_i]:
			inventory_data.slots[slot_i] = item_resource
			emit_signal("inventory_changed")
			return true
	
	return false
