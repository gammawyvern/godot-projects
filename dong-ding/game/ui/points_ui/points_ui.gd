class_name PointsUI extends Control

@onready var points_label: Label = $Points

func display_points(points: int) -> void:
	points_label.text = str(points)
