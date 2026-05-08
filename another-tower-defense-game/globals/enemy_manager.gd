extends Node

@onready var enemy_scene: PackedScene = preload("res://scenes/enemy/enemy.tscn")

func instantiate_enemy(enemy_layer: EnemyLayer) -> Enemy:
	var enemy_node: Enemy = enemy_scene.instantiate() as Enemy
	enemy_node.layer = enemy_layer
	return enemy_node
	
