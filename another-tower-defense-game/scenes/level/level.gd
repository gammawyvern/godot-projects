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
		_spawn_enemy_at_start(spawn_event.enemy_layer)
		_calculate_round_step(0)

# Enemy Management Functions

func _spawn_enemy(enemy_layer: EnemyLayer, path: Path2D, path_progress: float) -> void:
	var enemy: Enemy = EnemyManager.instantiate_enemy(enemy_layer)
	
	enemy.killed.connect(_handle_enemy_killed)
	enemy.reached_end_of_path.connect(enemy_path_network.handle_enemy_reached_end_of_path)
	
	path.add_child(enemy)
	enemy.progress = path_progress

func _spawn_enemy_at_start(enemy_layer: EnemyLayer) -> void:
	_spawn_enemy(enemy_layer, enemy_path_network.get_first_path(), 0)

func _handle_enemy_killed(enemy: Enemy, children_layers: Array[EnemyLayer]) -> void:
	var enemy_path: Path2D = enemy.get_parent()
	for enemy_layer in children_layers:
		_spawn_enemy(enemy_layer, enemy_path, enemy.progress)
	
	enemy.queue_free()
