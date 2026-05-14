class_name DartTower extends Tower

@export var projectile_scene: PackedScene

@onready var tower_sprite: Sprite2D = $TowerSprite

var _shoot_timer: float = 0 # TODO: Testing

func _ready() -> void:
	assert(projectile_scene != null)
	assert(tower_sprite != null)

func _process(delta: float) -> void:
	_shoot_timer += delta
	
	if _shoot_timer > 5:
		_shoot_timer -= 10
		_shoot()

func _shoot() -> void:
	var projectile_node: Projectile = projectile_scene.instantiate() as Projectile
	projectile_node.initialize(Vector2.UP)
	add_child(projectile_node)
