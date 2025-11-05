class_name InventorySlotUI extends Control

@export var slot_index: int

@onready var icon_texture: TextureRect = $IconTexture
@onready var quantity_label: Label = $QuantityLabel

func _ready() -> void:
	InventoryManager.connect("inventory_changed", refresh_display)

func refresh_display():
	var item_resource = InventoryManager.inventory_data.slots[slot_index]
	
	if item_resource:
		icon_texture.texture = item_resource.inventory_icon
		quantity_label.text = str(item_resource.stack_count)
		icon_texture.visible = true
		quantity_label.visible = true
	else:
		icon_texture.visible = false
		quantity_label.visible = false
