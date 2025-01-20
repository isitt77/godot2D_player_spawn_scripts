class_name Player
extends CharacterBody2D


var _move_input: Vector2 

enum _States {IDLE, WALK}
var _current_state: _States = _States.IDLE

@export var _movement_speed: float = 70
const SPEED_MULTIPLIER: float = 50

@onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var player_spawn_res: PlayerSpawnLocationRes


func _ready() -> void:
	_set_player_initial_position()
	_set_player_initial_direction()
	
func _physics_process(delta: float) -> void:
	
	_handle_state_transitions()
	_handle_state_actions(delta)
	move_and_slide()

func _handle_state_transitions():
	_move_input = Input.get_vector("move_left", 
	"move_right", "move_up", "move_down").normalized()
	
	if _move_input.abs() > Vector2.ZERO:
		_current_state = _States.WALK
	else:
		_current_state = _States.IDLE


func _handle_state_actions(delta):
	match _current_state:
		_States.WALK:
			
			var _walk_animaton_to_play: StringName = (
				_animated_sprite_2d.animation)
			
			if _move_input.x < 0 && _move_input.y == 0:
				_walk_animaton_to_play = "walk_left"
			
			if _move_input.x > 0 && _move_input.y == 0:
				_walk_animaton_to_play = "walk_right"
				
			if _move_input.y < 0:
				_walk_animaton_to_play = "walk_up"
				
			if _move_input.y > 0:
				_walk_animaton_to_play = "walk_down"
				
			velocity = (_move_input * _movement_speed * 
						delta * SPEED_MULTIPLIER)
						
			_animated_sprite_2d.play(_walk_animaton_to_play)
				
		_States.IDLE:
			
			if Input.is_action_just_released("move_left"):
				_animated_sprite_2d.animation = "idle_left"
			
			if Input.is_action_just_released("move_right"):
				_animated_sprite_2d.animation = "idle_right"
				
			if Input.is_action_just_released("move_up"):
				_animated_sprite_2d.animation = "idle_up"
				
			if Input.is_action_just_released("move_down"):
				_animated_sprite_2d.animation = "idle_down"
			
			velocity = velocity.move_toward(Vector2.ZERO, 
						_movement_speed)

# Player position and direction passed in from PlayerSpawnLocationRes
func _set_player_initial_position():
	var _new_player_position: Vector2 = (
		player_spawn_res.set_initial_player_position())
	
	position = _new_player_position
	
func _set_player_initial_direction():
	var _new_player_direction: String = (
		player_spawn_res.set_new_player_anim_direction())
		
	var _animation_to_play: StringName = "idle_" + _new_player_direction

	_animated_sprite_2d.animation = _animation_to_play
	
