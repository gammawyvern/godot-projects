extends Node

signal inventory_changed

# Note with this approach, the search is still O(N) if the inventory is full of stacks of the same item.

var inventory_data: InventoryData = null
var inventory_item_map: Dictionary[String, Array] = {}

# Initialize Inventory

func initalize_inventory_data(size: int) -> void:
	var new_inventory_data: InventoryData = InventoryData.new()
	new_inventory_data.stacks = []
	new_inventory_data.stacks.resize(size)
	inventory_data = new_inventory_data

func load_inventory_data(new_inventory_data: InventoryData) -> void:
	assert(new_inventory_data)
	
	inventory_data = new_inventory_data
	_reset_inventory_item_map()
	
	emit_signal("inventory_changed")

func _reset_inventory_item_map():
	assert(inventory_data, "Cannot reset inventory_item_map before initalizing inventory_data.")
	
	inventory_item_map.clear()
	
	for stack_i in range(inventory_data.stacks.size()):
		var stack: ItemStack = inventory_data.stacks[stack_i]
		if not stack:
			continue
		
		if not inventory_item_map.has(stack.item.id):
			inventory_item_map[stack.item.id] = []
		
		inventory_item_map[stack.item.id].append(stack_i)

# Add Items To Inventory

func pickup_item_stack(item_stack: ItemStack) -> ItemStack:
	assert(item_stack, "ItemStack is not valid.")
	assert(item_stack.count > 0, "ItemStack has invalid count.")
	
	if inventory_item_map.has(item_stack.item.id):
		for existing_item_stack_i in inventory_item_map[item_stack.item.id]:
			var existing_item_stack: ItemStack = inventory_data[existing_item_stack_i]
			_combine_item_stacks(item_stack, existing_item_stack)
			
			if item_stack.count <= 0:
				emit_signal("inventory_changed")
				return item_stack
	
	while item_stack.count > 0:
		var empty_stack_i: int = inventory_data.stacks.find(null)
		if empty_stack_i == -1:
			return item_stack
		
		var new_item_stack = ItemStack.new()
		new_item_stack.item = item_stack.item
		new_item_stack.count = 0
		
		_combine_item_stacks(item_stack, new_item_stack)
		assert(new_item_stack.count > 0, "New item stack count less than 0.")
		
		inventory_data.stacks[empty_stack_i] = new_item_stack
		
		if not inventory_item_map.has(new_item_stack.item.id):
			inventory_item_map[new_item_stack.item.id] = []
		
		var inventory_item_map_array = inventory_item_map[new_item_stack.item.id]
		inventory_item_map_array.insert(inventory_item_map_array.bsearch(empty_stack_i), empty_stack_i)
	
	emit_signal("inventory_changed")
	return item_stack

func _combine_item_stacks(src_item_stack: ItemStack, dest_item_stack: ItemStack) -> void:
	assert(src_item_stack.item.id == dest_item_stack.item.id, "Can't combine item stacks of different item id.")
	
	var remaining_dest_item_stack_count: int = dest_item_stack.item.max_stack_count - dest_item_stack.count
	var transfer_count = min(src_item_stack.count, remaining_dest_item_stack_count)
	dest_item_stack.count += transfer_count
	src_item_stack -= transfer_count
	
	assert(dest_item_stack.count <= dest_item_stack.item.max_stack_count)
	assert(src_item_stack.count >= 0)
