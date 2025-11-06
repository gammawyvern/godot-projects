class_name InventorySlot extends Control

@export var item_stack_icon_scene: PackedScene

var _item_stack_icon: ItemStackIcon

func display_item_stack(item_stack: ItemStack) -> void:
	assert(item_stack, "Invalid item_stack passed to InventorySlot.")
	
	if _item_stack_icon:
		_item_stack_icon.display_item_stack(item_stack)
	else:
		var new_item_stack_icon = item_stack_icon_scene.instantiate() as ItemStackIcon
		add_child(new_item_stack_icon)
		
		new_item_stack_icon.display_item_stack(item_stack)
		_item_stack_icon = new_item_stack_icon

func clear_item_stack() -> void:
	assert(_item_stack_icon, "ItemStackIcon is already empty.")
	
	_item_stack_icon.queue_free()
	_item_stack_icon = null
