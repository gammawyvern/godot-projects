extends Control

@onready var inventory_slot_grid: GridContainer = $InventorySlotGrid

func _ready() -> void:
	assert(inventory_slot_grid, "InventorySlotGrid not found.")

	InventoryManager.connect("inventory_changed", update_inventory_slots)

func update_inventory_slots():
	assert(InventoryManager.inventory_data)
	assert(InventoryManager.inventory_data.stacks.size() >= inventory_slot_grid.get_children().size())
	
	var inventory_slots = inventory_slot_grid.get_children()
	var inventory_stacks = InventoryManager.inventory_data.stacks
	
	for inventory_slot_i in range(inventory_slots.size()):
		var inventory_slot = inventory_slots[inventory_slot_i] as InventorySlot
		var inventory_stack = inventory_stacks[inventory_slot_i]
		
		if inventory_stack:
			inventory_slot.display_item_stack(inventory_stack)
