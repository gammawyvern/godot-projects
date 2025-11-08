extends Node

@export var default_inventory: InventoryData

func _ready() -> void:
	assert(default_inventory, "GameLoader does not have a default inventory selected.")
	
	InventoryManager.load_inventory_data(default_inventory.duplicate_inventory_data())

# FIXME Testing

var test_potion: BaseItem = preload("res://game/items/test_items/TestPotion.tres")

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("player_reset_rotation"):
		return
	
	var item_stack: ItemStack = ItemStack.create_stack(test_potion, 4)
	var item_stack_position = Vector2(50 * randf() + 800, 50 * randf() + 200)
	ItemManager.spawn_ground_item_stack(item_stack, item_stack_position, self)
