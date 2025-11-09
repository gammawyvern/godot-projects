class_name Obstacle extends Area2D

var _velocity: Vector2
var _initialized: bool = false

func initialize(direction: Vector2, speed: float):
	_velocity = speed * direction.normalized()
	_initialized = true

func _physics_process(delta: float) -> void:
	if _initialized:
		position += delta * _velocity

# TODO Add logic for nearby passes
