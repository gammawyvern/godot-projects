extends Node2D

@export var BallScene: PackedScene

var current_ball: Node2D = null

func _ready() -> void:
	assert(BallScene != null, "BallLauncher is missing a ball PackedScene.")

func _input(event: InputEvent) -> void:
	# TODO: Add click action, handle here
	# Initialize new BallScene if current_ball is null
	pass
