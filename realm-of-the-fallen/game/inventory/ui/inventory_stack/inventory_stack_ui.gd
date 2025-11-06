class_name InventoryStackUI extends Control

@onready var icon_texture: TextureRect = $IconTexture
@onready var count_label: Label = $CountLabel

const default_quantity_label_text: String = "0 "

func _ready() -> void:
	assert(icon_texture)
	assert(count_label)

func display_item_stack(item_stack: ItemStack):
	if item_stack:
		icon_texture.texture = item_stack.item.inventory_icon
		count_label.text = "%d " % item_stack.count 
		
		icon_texture.visible = true
		count_label.visible = true
	else:
		icon_texture.visible = false
		count_label.visible = false
