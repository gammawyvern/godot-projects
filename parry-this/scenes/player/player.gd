class_name Player extends CharacterBody2D

enum PlayerState{
	IDLE, HURT, PARRY, VULNERABLE
}

@export var move_speed: float = 200
@export var parry_duration: float = 1
@export var parry_cooldown_duration: float = 0.2

@onready var parry_timer: Timer = $ParryTimer
@onready var hurt_box: Area2D = $HurtBox
# @onready var sprite: Sprite2D = $Sprite

var player_state: PlayerState = PlayerState.IDLE : set = _change_state

func _change_state(new_state: PlayerState) -> void:
	match new_state:
		PlayerState.IDLE:
			modulate = Color(1, 1, 1)
		PlayerState.HURT:
			modulate = Color(1, 0, 0)
		PlayerState.PARRY:
			modulate = Color(0, 0, 1)
			parry_timer.start(parry_duration)
		PlayerState.VULNERABLE:
			modulate = Color(0, 1, 0)
			parry_timer.start(parry_cooldown_duration)
		_:
			assert(false)
	
	player_state = new_state

func _ready() -> void:
	assert(parry_timer != null)
	assert(hurt_box != null)
	# assert(sprite != null)
	
	parry_timer.timeout.connect(_handle_parry_timer_timeout)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	velocity = move_speed * direction
	move_and_slide()

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("player_parry"):
		return
	
	if can_parry():
		player_state = PlayerState.PARRY

func _handle_parry_timer_timeout() -> void:
	match player_state:
		PlayerState.PARRY:
			player_state = PlayerState.VULNERABLE
		PlayerState.VULNERABLE:
			player_state = PlayerState.IDLE
		_:
			assert(false)

func can_parry() -> bool:
	return player_state == PlayerState.IDLE
