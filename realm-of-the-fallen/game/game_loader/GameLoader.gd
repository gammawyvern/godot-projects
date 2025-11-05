extends Node

@export var default_inventory: InventoryData

func _ready() -> void:
	assert(default_inventory, "GameLoader does not have a default inventory selected.")
	
	if not InventoryManager.inventory_data:
		initialize_new_inventory()

func initialize_new_inventory() -> void:
	InventoryManager.load_inventory_data(default_inventory.duplicate())
