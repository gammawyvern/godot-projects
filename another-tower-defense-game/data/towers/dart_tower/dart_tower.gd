class_name DartTower extends Tower

@export var shot_delay_time: float = 1
@export var projectile_scene: PackedScene

@onready var shot_delay_timer: Timer = $ShotDelayTimer
@onready var tower_sprite: Sprite2D = $TowerSprite
@onready var shot_area: Area2D = $ShotArea

func _ready() -> void:
	assert(shot_delay_timer != null)
	assert(projectile_scene != null)
	assert(tower_sprite != null)
	assert(shot_delay_time > 0)
	
	shot_delay_timer.wait_time = shot_delay_time

func _on_shot_area_area_entered(area: Area2D) -> void:
	if can_shoot():
		_shoot(area)

func _shoot(target: Node2D) -> void:
	assert(can_shoot())
	
	var shot_direction: Vector2 = target.global_position - global_position
	tower_sprite.rotation = shot_direction.angle()
	
	var projectile_node: Projectile = projectile_scene.instantiate() as Projectile
	projectile_node.initialize(shot_direction)
	add_child.call_deferred(projectile_node)
	
	shot_delay_timer.start()

func can_shoot() -> bool:
	return shot_delay_timer.is_stopped()

func get_target() -> Node2D:
	var targets: Array[Area2D] = shot_area.get_overlapping_areas()
	if targets.is_empty():
		return null
	
	targets.sort_custom(func(a: Area2D, b: Area2D): return a.global_position.distance_to(global_position) < b.global_position.distance_to(global_position))
	
	return targets[0]

func _on_shot_delay_timer_timeout() -> void:
	var target: Node2D = get_target()
	if target == null:
		return
	
	_shoot(target)
