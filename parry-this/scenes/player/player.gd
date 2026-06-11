class_name Player extends CharacterBody2D

@export var move_speed: float = 200

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	velocity = move_speed * direction
	move_and_slide()
