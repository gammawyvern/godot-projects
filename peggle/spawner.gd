extends Node2D

const spawn_force: int = 300

@export var spawnable: PackedScene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		var direction: Vector2 = event.position - position
		spawn(direction)

func spawn(direction: Vector2) -> void:
	if spawnable and direction:
		var spawned_node = spawnable.instantiate() as RigidBody2D
		add_child(spawned_node)
		
		var initial_impulse = spawn_force * direction.normalized()
		spawned_node.apply_impulse(initial_impulse)
