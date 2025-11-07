class_name GroundItemStack extends Area2D

@onready var item_stack_icon: ItemStackIcon = $ItemStackIcon

var _item_stack: ItemStack

func _ready() -> void:
	assert(item_stack_icon)

func set_item_stack(item_stack: ItemStack) -> void:
	assert(item_stack, "Invalid item_stack passed to InventorySlot.")
	
	_item_stack = item_stack
	item_stack_icon.display_item_stack(item_stack)
	set_deferred("monitorable", true)

func pickup() -> void:
	assert(_item_stack, "ItemStack not set before pickup.")
	
	var leftover_item_stack: ItemStack = InventoryManager.pickup_item_stack(_item_stack)
	
	if leftover_item_stack.count <= 0:
		queue_free()
	else:
		set_item_stack(leftover_item_stack)
