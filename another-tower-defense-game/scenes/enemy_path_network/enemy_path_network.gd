class_name EnemyPathNetwork extends Node2D

func _ready() -> void:
	var children: Array[Node] = get_children()
	assert(children.all(func(child): return child is Path2D))

# Path Logic Functions

func handle_enemy_reached_end_of_path(enemy: Enemy, current_path: Path2D, excess_progress: float) -> void:
	var next_path: Path2D = get_next_path(current_path)
	
	if next_path:
		enemy.switch_to_path(next_path, excess_progress)
	else:
		# TODO: Take damage, probably create a global LevelStats singleton to track health, money, etc.
		enemy.queue_free()

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
	
	return paths.get(current_path_index + 1)
