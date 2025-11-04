extends CharacterBody2D

@export var movement_speed: float = 200

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	velocity = movement_speed * direction
	move_and_slide()
