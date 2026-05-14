class_name Projectile extends Node2D

@export var speed: float = 250
@export var damage: int = 1

@onready var projectile_sprite: Sprite2D = $ProjectileSprite

var _initialized: bool = false
var _direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	assert(projectile_sprite != null)
	assert(_initialized)
	
	projectile_sprite.rotation = _direction.angle()

func initialize(direction: Vector2) -> void:
	assert(!_initialized)
	assert(direction != Vector2.ZERO)
	
	_direction = direction
	_initialized = true

func _process(delta: float) -> void:
	if !_initialized:
		return
	
	position += delta * speed * _direction
	projectile_sprite.rotation = _direction.angle()
