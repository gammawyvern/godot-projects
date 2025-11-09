extends Control

@export var level_scene: PackedScene

func _on_start_button_pressed() -> void:
	assert(level_scene)
	
	get_tree().change_scene_to_packed(level_scene)
