class_name Level extends Node2D

# TODO: Create signal connecting enemies to level, when they reach end of path

@export var level_data: LevelData
@export var enemy_scene: PackedScene

@onready var enemy_path_network: EnemyPathNetwork = $EnemyPathNetwork

var _is_round_in_progress: bool = false
var _round: int = -1
var _round_time: float = 0
var _round_spawn_events: Array[SpawnEvent] = []

func _ready() -> void:
	assert(level_data != null)

func _process(delta: float) -> void:
	_calculate_round_step(delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and !_is_round_in_progress:
		_begin_next_round()

# Round Functions

func _begin_next_round():
	_round += 1
	_round_time = 0
	
	var round_data: RoundData = level_data.rounds[_round]
	_round_spawn_events.assign(round_data.to_spawn_events())
	
	_is_round_in_progress = true

func _calculate_round_step(delta: float) -> void:
	if !_is_round_in_progress:
		return
	
	if _round_spawn_events.is_empty():
		return
	
	_round_time += delta
	
	if _round_time > _round_spawn_events[0].time:
		var spawn_event: SpawnEvent = _round_spawn_events.pop_front()
		_spawn_enemy(spawn_event.enemy_layer)
		_calculate_round_step(0)

# Enemy Functions

func _spawn_enemy(enemy_layer: EnemyLayer) -> void:
	var first_path: Path2D = get_paths().get(0)
	assert(first_path != null)
	
	var enemy_node: Enemy = EnemyManager.instantiate_enemy(enemy_layer)
	first_path.add_child(enemy_node)

# Path Functions

func get_paths() -> Array[Path2D]:
	var paths: Array[Path2D] = []
	paths.assign(enemy_path_network.get_children())
	return paths
