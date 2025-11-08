extends Node

@onready var ground_item_stack_scene: PackedScene = preload("res://game/items/ground_item_stack/GroundItemStack.tscn")

func spawn_ground_item_stack(item_stack: ItemStack, item_stack_position: Vector2, item_stack_parent: Node = get_parent()) -> void:
	assert(item_stack_parent, "Invalid parent to add item to.")
	
	var ground_item_stack: GroundItemStack = ground_item_stack_scene.instantiate()
	ground_item_stack.position = item_stack_position
	item_stack_parent.add_child(ground_item_stack)
	ground_item_stack.set_item_stack(item_stack)
