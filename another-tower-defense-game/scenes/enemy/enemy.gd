class_name Enemy extends PathFollow2D

signal killed(children: Array[EnemyLayer])
signal reached_end_of_path

var layer: EnemyLayer

var damage_taken: int = 0

func _ready() -> void:
	assert(layer != null)
	assert(get_parent() is PathFollow2D)
	
	self.modulate = layer.color

## Takes passed damage.
## Returns an array holding what children should be spawned after damage
func damage(amount: int) -> void:
	damage_taken += amount
	
	if damage_taken >= layer.health:
		killed.emit(_calculate_children())

func _calculate_children() -> Array[EnemyLayer]:
	# TODO: Calculate what to actually spawn
	return []
