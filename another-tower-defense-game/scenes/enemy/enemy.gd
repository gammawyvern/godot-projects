class_name Enemy extends PathFollow2D

signal reached_end_of_path(enemy: Enemy, current_path: Path2D, excess_progress: float)
signal killed(enemy: Enemy, children_layers: Array[EnemyLayer])

const SPEED_RATIO: float = 50

var layer: EnemyLayer
var damage_taken: int = 0

func _ready() -> void:
	assert(layer != null)
	assert(get_parent() is Path2D)
	
	self.modulate = layer.color

func _process(delta: float) -> void:
	_move(delta)

# Movement Logic Functions

func _move(delta: float) -> void:
	progress += delta * SPEED_RATIO * layer.speed
	
	if progress_ratio == 1:
		# TODO: Calculate and pass excess distance to next path
		reached_end_of_path.emit(self, get_parent(), 0)

func switch_to_path(new_path: Path2D, starting_progress: float) -> void:
	assert(new_path != null)
	
	reparent(new_path)
	progress = starting_progress

# Damage Logic Functions

func damage(amount: int) -> void:
	damage_taken += amount
	
	if damage_taken >= layer.health:
		get_parent().remove_child.call_deferred(self)
		killed.emit(self, _calculate_children())

func _calculate_children() -> Array[EnemyLayer]:
	# TODO: Calculate what to actually spawn
	return []

# Signals

func _on_enemy_area_area_entered(area: Area2D) -> void:
	var area_parent: Node2D = area.get_parent()
	if area_parent is not Projectile:
		return
	
	var projectile: Projectile = area_parent as Projectile
	damage(projectile.damage)
	projectile.hit_enemy()
