class_name RoundData extends Resource

@export var spawns: Array[SpawnData]

func to_spawn_events() -> Array[SpawnEvent]:
	var spawn_events: Array[SpawnEvent] = []
	
	for spawn_data in self.spawns:
		for spawn_count in range(spawn_data.enemy_count):
			var spawn_event: SpawnEvent = SpawnEvent.new()
			spawn_event.time = spawn_data.time + (spawn_count * spawn_data.interval)
			spawn_event.enemy_layer = spawn_data.enemy_layer
			
			spawn_events.append(spawn_event)
	
	return spawn_events
