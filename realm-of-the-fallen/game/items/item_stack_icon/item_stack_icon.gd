class_name ItemStackIcon extends Control

@onready var icon_sprite: Sprite2D = $IconSprite
@onready var count_label: Label = $CountLabel

func display_item_stack(item_stack: ItemStack):
	assert(item_stack, "Invalid item_stack passed.")
	
	icon_sprite.texture = item_stack.item.icon
	count_label.text = "%d " % item_stack.count 
