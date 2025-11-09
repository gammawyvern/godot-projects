class_name PlayerBall extends Area2D

signal gained_points(amount: int)
signal game_over

const SPEED: float = 400

@export var starting_checkpoint: Checkpoint

@onready var _direction: Vector2 = starting_checkpoint.jump_direction

var _moving: bool = false
var _dead: bool = false

func _physics_process(delta: float) -> void:
	if not _moving:
		return
	
	position += delta * SPEED * _direction

func _input(event: InputEvent) -> void:
	if not _moving and event.is_action("player_jump"):
		_moving = true

func _on_area_entered(area: Area2D) -> void:
	if area is Checkpoint:
		var checkpoint = area as Checkpoint
		_direction = checkpoint.jump_direction
		_moving = false
		
		emit_signal("gained_points", 1)
	
	if area is Obstacle:
		_dead = true
		emit_signal("game_over")
		queue_free()

func _on_area_exited(area: Area2D) -> void:
	if area is NearbyObstacleArea and not _dead:
		emit_signal("gained_points", 5)
