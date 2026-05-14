class_name DartTower extends Tower

@export var shot_delay_time: float = 1
@export var projectile_scene: PackedScene

@onready var shot_delay_timer: Timer = $ShotDelayTimer
@onready var tower_sprite: Sprite2D = $TowerSprite

func _ready() -> void:
	assert(shot_delay_timer != null)
	assert(projectile_scene != null)
	assert(tower_sprite != null)
	assert(shot_delay_time > 0)
	
	shot_delay_timer.wait_time = shot_delay_time

func _process(_delta: float) -> void:
	if can_shoot():
		_shoot(Vector2.DOWN)

func can_shoot() -> bool:
	return shot_delay_timer.is_stopped()

func _shoot(direction: Vector2) -> void:
	assert(direction.length() != 0)
	assert(can_shoot())
	
	tower_sprite.rotation = direction.angle()
	
	var projectile_node: Projectile = projectile_scene.instantiate() as Projectile
	projectile_node.initialize(direction)
	add_child(projectile_node)
	
	shot_delay_timer.start()
