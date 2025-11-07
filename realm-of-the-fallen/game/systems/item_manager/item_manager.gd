extends Node

@onready var ground_item_stack_scene: PackedScene = preload("res://game/items/ground_item_stack/GroundItemStack.tscn")

func spawn_ground_item_stack(item_stack: ItemStack, global_position: Vector2) -> void:
	var ground_item_stack: GroundItemStack = ground_item_stack_scene.instantiate()
	ground_item_stack.position = global_position
	get_parent().add_child(ground_item_stack)
	ground_item_stack.set_item_stack(item_stack)
