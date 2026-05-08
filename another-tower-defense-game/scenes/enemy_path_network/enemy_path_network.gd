class_name EnemyPathNetwork extends Node2D

var _path_network: Array[Path2D] = []

func _ready() -> void:
	var children: Array[Node] = get_children()
	assert(children.all(func(child): return child is Path2D))
	
	_path_network.assign(children)
	assert(_path_network.size() > 0)

func _process(_delta: float) -> void:
	# Update children on path network, add logic for switching sections
	pass
