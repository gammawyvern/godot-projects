class_name InventorySlot extends Control

@onready var item_stack_icon: ItemStackIcon = $ItemStackIcon

func _ready() -> void:
	assert(item_stack_icon)

func display_item_stack(item_stack: ItemStack) -> void:
	assert(item_stack, "Invalid item_stack passed to InventorySlot.")
	item_stack_icon.display_item_stack(item_stack)

func clear_item_stack() -> void:
	item_stack_icon.clear_item_stack()
