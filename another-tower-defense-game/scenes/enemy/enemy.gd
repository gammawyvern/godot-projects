class_name Enemy extends PathFollow2D

var _layer: EnemyLayer

func _ready() -> void:
	assert(_layer != null)
