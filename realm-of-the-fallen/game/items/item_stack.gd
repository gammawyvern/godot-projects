class_name ItemStack extends Resource

@export var item: BaseItem
@export var count: int = 0

static func create_stack(stack_item: BaseItem, stack_count: int) -> ItemStack:
	var new_item_stack = ItemStack.new()
	new_item_stack.item = stack_item
	new_item_stack.count = stack_count
	
	return new_item_stack
