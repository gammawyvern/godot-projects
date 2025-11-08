extends CharacterBody2D

@export var movement_speed: float = 200
@export var camera_rotate_speed: float = 0.8 * PI

@onready var floor_tiles: TileMapLayer = $"../FloorTiles"

func _physics_process(delta: float) -> void:
	_physics_handle_rotation_input(delta)
	_physics_handle_movement_input(delta)
	move_and_slide()

func _physics_handle_rotation_input(delta: float) -> void:
	if Input.is_action_just_pressed("player_reset_rotation"):
		rotation = 0
		return
	
	var rotation_input: float = Input.get_axis("player_rotate_left", "player_rotate_right")
	if rotation_input != 0:
		rotation += delta * camera_rotate_speed * rotation_input

func _physics_handle_movement_input(_delta: float) -> void:
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	velocity = movement_speed * direction.rotated(rotation)
	
	# Add ground tile speed multipliers
	var tile_pos = floor_tiles.local_to_map(global_position)
	var tile_data = floor_tiles.get_cell_tile_data(tile_pos)
	if tile_data:
		var movement_speed_multi: float = tile_data.get_custom_data("speed_multiplier")
		if movement_speed_multi != null:
			velocity *= movement_speed_multi

# Signals

func _on_pickup_area_area_entered(area: Area2D) -> void:
	var ground_item_stack = area as GroundItemStack
	ground_item_stack.pickup()
