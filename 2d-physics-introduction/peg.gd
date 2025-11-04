extends StaticBody2D

@onready var peg_shape: CircleShape2D = $Shape.shape
var peg_color: Color = Color(0.8, 0.5, 0.5)

func _draw() -> void:
	draw_circle(Vector2.ZERO, peg_shape.radius, peg_color)
