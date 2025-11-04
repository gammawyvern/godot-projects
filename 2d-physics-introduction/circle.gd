extends RigidBody2D

@onready var shape: CircleShape2D = $CircleCollisionShape.shape

func _draw():
	draw_circle(Vector2.ZERO, shape.radius, Color(0.2, 0.8, 0.8))
