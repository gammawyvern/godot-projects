class_name Level extends Node2D

@export var level_data: LevelData

var _is_round_in_progress: bool = false
var _round: int = -1
var _round_time: float = 0
var _round_spawn_events: Array[SpawnEvent] = []

func _ready() -> void:
	assert(level_data != null)

func _process(delta: float) -> void:
	if _is_round_in_progress:
		_round_time += delta

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and !_is_round_in_progress:
		_begin_next_round()

func _begin_next_round():
	_round += 1
	_round_time = 0
	
	var round_data: RoundData = level_data.rounds[_round]
	_round_spawn_events.assign(round_data.to_spawn_events())
	
	_is_round_in_progress = true
