class_name InventoryData extends Resource

@export var stacks: Array[ItemStack] = []

func duplicate_inventory_data() -> InventoryData:
	var new_inventory_data: InventoryData = duplicate(true)
	
	assert(stacks.size() == new_inventory_data.stacks.size(), "Invalid InventoryData copy.")
	for item_stack_i in range(new_inventory_data.stacks.size()):
		if (new_inventory_data.stacks[item_stack_i]):
			new_inventory_data.stacks[item_stack_i] = new_inventory_data.stacks[item_stack_i].duplicate(true)
			new_inventory_data.stacks[item_stack_i].item = stacks[item_stack_i].item
	
	return new_inventory_data
