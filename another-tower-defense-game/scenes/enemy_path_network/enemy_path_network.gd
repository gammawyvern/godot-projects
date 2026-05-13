class_name EnemyPathNetwork extends Node2D

signal enemy_leaked(enemy: Enemy)

@onready var _first_path: Path2D = get_children().front()
@onready var _last_path: Path2D = get_children().back()

func _ready() -> void:
	var children: Array[Node] = get_children()
	assert(children.all(func(child): return child is Path2D))
	
	assert(_first_path)	
	assert(_last_path)

# Path Logic Functions

func handle_enemy_reached_end_of_path(enemy: Enemy, current_path: Path2D, excess_progress: float) -> void:
	var next_path: Path2D = get_next_path(current_path)
	
	if next_path:
		enemy.switch_to_path(next_path, excess_progress)
	else:
		enemy.get_parent().remove_child(enemy)
		enemy_leaked.emit(enemy)

# Path Getters

func get_paths() -> Array[Path2D]:
	var paths: Array[Path2D] = []
	paths.assign(get_children())
	return paths

func get_first_path() -> Path2D:
	var paths: Array[Path2D] = get_paths()
	return paths.get(0)

func get_next_path(current_path: Path2D) -> Path2D:
	var paths: Array[Path2D] = get_paths()
	var current_path_index: int = paths.find(current_path)
	if current_path_index == -1:
		return null
	
	var next_path_index: int = current_path_index + 1
	if next_path_index >= paths.size():
		return null
	
	return paths.get(next_path_index)

func get_last_path() -> Path2D:
	var paths: Array[Path2D] = get_paths()
	return paths.get(paths.size()-1)

func get_all_enemies() -> Array[Enemy]:
	var all_enemies: Array[Enemy] = []
	for path in get_paths():
		var path_enemies = path.get_children().filter(func(child): return child is Enemy)
		all_enemies.assign(path_enemies)
	
	return all_enemies
