extends Node2D

@export var obstacle: PackedScene

const LANE_OFFSET: float = 240
const LANE_SIZE: float = 48

func _on_obstacle_timer_timeout() -> void:
	var new_obstacle = obstacle.instantiate() as Obstacle
	
	if randf() < 0.5:
		var lane_position = 2 * LANE_SIZE * _random_lane()
		new_obstacle.position = Vector2(-64, lane_position + LANE_OFFSET)
		add_child(new_obstacle)
		new_obstacle.initialize(Vector2(1, 0), 200)
	else:
		var lane_position = (2 * LANE_SIZE * _random_lane()) + LANE_SIZE
		new_obstacle.position = Vector2(1216, lane_position + LANE_OFFSET)
		add_child(new_obstacle)
		new_obstacle.initialize(Vector2(-1, 0), 200)

func _random_lane() -> int:
	return randi() % 3
