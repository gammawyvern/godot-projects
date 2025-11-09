extends Area2D

func _on_area_entered(area: Area2D) -> void:
	var obstacle = area as Obstacle
	obstacle.queue_free()
