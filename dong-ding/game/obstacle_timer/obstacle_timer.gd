extends Timer

@export var min_time_interval: float
@export var max_time_interval: float

func _ready() -> void:
	assert(max_time_interval)
	assert(min_time_interval)

func _on_timeout() -> void:
	var new_wait_time = ((max_time_interval - min_time_interval) * randf()) + min_time_interval
	start(new_wait_time)
