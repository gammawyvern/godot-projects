extends Node

@export var default_inventory: InventoryData

func _ready() -> void:
	assert(default_inventory, "GameLoader does not have a default inventory selected.")
	
	InventoryManager.load_inventory_data(default_inventory.duplicate_inventory_data())
