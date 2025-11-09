extends Node2D

const LANE_OFFSET: float = 240
const LANE_SIZE: float = 48

@export var obstacle: PackedScene

@onready var points_ui: PointsUI = $UI/PointsUI
@onready var game_over_ui = $UI/GameOverUI
@onready var obstacle_timer: Timer = $ObstacleTimer

var _points: int = 0

func _on_obstacle_timer_timeout() -> void:
	var new_obstacle = obstacle.instantiate() as Obstacle
	var new_obstacle_speed: float = (25 * randf()) + 200
	
	if randf() < 0.5:
		var lane_position = 2 * LANE_SIZE * _random_lane()
		new_obstacle.position = Vector2(-64, lane_position + LANE_OFFSET)
		add_child(new_obstacle)
		new_obstacle.initialize(Vector2(1, 0), new_obstacle_speed)
	else:
		var lane_position = (2 * LANE_SIZE * _random_lane()) + LANE_SIZE
		new_obstacle.position = Vector2(1216, lane_position + LANE_OFFSET)
		add_child(new_obstacle)
		new_obstacle.initialize(Vector2(-1, 0), new_obstacle_speed)

func _random_lane() -> int:
	return randi() % 3

func _on_player_ball_gained_points(amount: int) -> void:
	_points += amount
	points_ui.display_points(_points)

func _on_player_ball_game_over() -> void:
	obstacle_timer.stop()
	game_over_ui.visible = true
