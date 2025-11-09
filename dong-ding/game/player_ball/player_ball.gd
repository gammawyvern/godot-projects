extends Area2D

@export var starting_checkpoint: Checkpoint

const SPEED: float = 400

@onready var _direction: Vector2 = starting_checkpoint.jump_direction
var _moving: bool = false

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
	
	if area is Obstacle:
		print("You suck ass.")
